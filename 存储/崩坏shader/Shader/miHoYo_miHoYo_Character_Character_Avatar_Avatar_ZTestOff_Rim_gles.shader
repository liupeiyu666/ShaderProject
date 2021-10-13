//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar_ZTestOff_Rim" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_LightMapTex ("Light Map Tex (RGB)", 2D) = "gray" { }
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_SecondShadow ("Second Shadow Threshold", Range(0, 1)) = 0.51
_FirstShadowMultColor ("First Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
_SecondShadowMultColor ("Second Shadow Multiply Color", Color) = (0.75,0.6,0.65,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
[Toggle(LOOKUP_COLOR)] _LookupColor ("Lookup Color", Float) = 0
[Toggle(LOOKUP_COLOR_BILINEAR)] _LookupColorBilinear ("Lookup Color Bilinear", Float) = 0
_factorTex ("Factor Tex", 2D) = "white" { }
_indexTex ("Index Tex", 2D) = "white" { }
_tableTex ("Lookup Tex", 2D) = "white" { }
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DTTex ("Distortion Tex", 2D) = "gray" { }
_DTIntensity ("Distortion Intensity", Range(1, 9)) = 5
_DTPlaySpeed ("Distortion Play Speed", Float) = 0
_DTNormalDisplacment ("Distortion Normal Displacment", Float) = 0
_DTUVScaleInX ("Distortion UV Scale in X", Float) = 1
_DTUVScaleInY ("Distortion UV Scale in Y", Float) = 1
_DTFresnel ("Distortion Fresnel Params", Vector) = (1,1,0,0)
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent" "Reflected" = "Reflected" "RenderType" = "Transparent" }
 Pass {
  Name "COMPLEX_TRANS"
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  ZTest Off
  GpuProgramID 60250
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_23;
    scrpos_23 = xlv_TEXCOORD3;
    mediump float a_24;
    a_24 = xlv_TEXCOORD3.z;
    if ((a_24 < 0.95)) {
      scrpos_23.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_24 = (a_24 * 17.0);
      highp float tmpvar_25;
      tmpvar_25 = (scrpos_23.y / 4.0);
      highp float tmpvar_26;
      tmpvar_26 = (fract(abs(tmpvar_25)) * 4.0);
      highp float tmpvar_27;
      if ((tmpvar_25 >= 0.0)) {
        tmpvar_27 = tmpvar_26;
      } else {
        tmpvar_27 = -(tmpvar_26);
      };
      highp float tmpvar_28;
      tmpvar_28 = (scrpos_23.x / 4.0);
      highp float tmpvar_29;
      tmpvar_29 = (fract(abs(tmpvar_28)) * 4.0);
      highp float tmpvar_30;
      if ((tmpvar_28 >= 0.0)) {
        tmpvar_30 = tmpvar_29;
      } else {
        tmpvar_30 = -(tmpvar_29);
      };
      highp float x_31;
      x_31 = ((a_24 - _DITHERMATRIX[
        int(tmpvar_27)
      ][
        int(tmpvar_30)
      ]) - 0.01);
      if ((x_31 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD3;
    mediump float a_34;
    a_34 = xlv_TEXCOORD3.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_76;
    scrpos_76 = xlv_TEXCOORD3;
    mediump float a_77;
    a_77 = xlv_TEXCOORD3.z;
    if ((a_77 < 0.95)) {
      scrpos_76.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_77 = (a_77 * 17.0);
      highp float tmpvar_78;
      tmpvar_78 = (scrpos_76.y / 4.0);
      highp float tmpvar_79;
      tmpvar_79 = (fract(abs(tmpvar_78)) * 4.0);
      highp float tmpvar_80;
      if ((tmpvar_78 >= 0.0)) {
        tmpvar_80 = tmpvar_79;
      } else {
        tmpvar_80 = -(tmpvar_79);
      };
      highp float tmpvar_81;
      tmpvar_81 = (scrpos_76.x / 4.0);
      highp float tmpvar_82;
      tmpvar_82 = (fract(abs(tmpvar_81)) * 4.0);
      highp float tmpvar_83;
      if ((tmpvar_81 >= 0.0)) {
        tmpvar_83 = tmpvar_82;
      } else {
        tmpvar_83 = -(tmpvar_82);
      };
      highp float x_84;
      x_84 = ((a_77 - _DITHERMATRIX[
        int(tmpvar_80)
      ][
        int(tmpvar_83)
      ]) - 0.01);
      if ((x_84 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 baseTexColor_4;
  mediump vec3 tex_Light_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_5 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_4 = tmpvar_8;
  mediump float threshold_9;
  mediump float D_10;
  mediump vec3 diffColor_11;
  diffColor_11 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = (xlv_COLOR0.x * tex_Light_Color_5.y);
  D_10 = tmpvar_12;
  threshold_9 = 0.0;
  if ((tmpvar_12 < 0.09)) {
    threshold_9 = ((xlv_COLOR1 + tmpvar_12) * 0.5);
    if ((threshold_9 < _SecondShadow)) {
      diffColor_11 = (baseTexColor_4 * _SecondShadowMultColor);
    } else {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_12 >= 0.5)) {
      D_10 = ((tmpvar_12 * 1.2) - 0.1);
    } else {
      D_10 = ((D_10 * 1.25) - 0.125);
    };
    threshold_9 = ((xlv_COLOR1 + D_10) * 0.5);
    if ((threshold_9 < _LightArea)) {
      diffColor_11 = (baseTexColor_4 * _FirstShadowMultColor);
    } else {
      diffColor_11 = baseTexColor_4;
    };
  };
  outColor_6.xyz = diffColor_11;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_15;
  mediump vec3 color_16;
  mediump vec3 H_17;
  H_17 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_18 = tmpvar_19;
    H_17 = normalize((_CustomLightDir.xyz + V_18));
  };
  mediump float tmpvar_20;
  tmpvar_20 = pow (max (dot (N_3, H_17), 0.0), _Shininess);
  if ((tmpvar_20 >= (1.0 - tex_Light_Color_5.z))) {
    color_16 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_5.x);
  } else {
    color_16 = vec3(0.0, 0.0, 0.0);
  };
  outColor_6.xyz = (diffColor_11 + color_16);
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_21;
  color_21 = outColor_6.xyz;
  mediump vec3 tmpvar_22;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_22 = _lightProbColor.xyz;
  } else {
    tmpvar_22 = vec3(1.0, 1.0, 1.0);
  };
  color_21 = (outColor_6.xyz * tmpvar_22);
  outColor_6.xyz = color_21;
  mediump vec4 tmpvar_23;
  highp vec3 N_24;
  N_24 = N_3;
  highp vec3 V_25;
  V_25 = V_2;
  mediump vec4 rgColor_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (clamp ((1.001 - 
    dot (V_25, N_24)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_27 = (_RGBias + (tmpvar_28 * _RGScale));
  rgColor_26.xyz = (tmpvar_27 * _RGColor).xyz;
  rgColor_26.w = _RGBloomFactor;
  mediump float tmpvar_29;
  tmpvar_29 = clamp (tmpvar_27, 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_6, rgColor_26, vec4((tmpvar_29 * _RGRatio)));
  tmpvar_23 = tmpvar_30;
  outColor_6.xyz = tmpvar_23.xyz;
  outColor_6.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD3;
    mediump float a_32;
    a_32 = xlv_TEXCOORD3.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, xlv_TEXCOORD0);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_5.xyz = diffColor_21;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (N_3, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_4.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_21 + color_26);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_31;
  color_31 = outColor_5.xyz;
  mediump vec3 tmpvar_32;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_32 = _lightProbColor.xyz;
  } else {
    tmpvar_32 = vec3(1.0, 1.0, 1.0);
  };
  color_31 = (outColor_5.xyz * tmpvar_32);
  outColor_5.xyz = color_31;
  mediump vec4 tmpvar_33;
  highp vec3 N_34;
  N_34 = N_3;
  highp vec3 V_35;
  V_35 = V_2;
  mediump vec4 rgColor_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = pow (clamp ((1.001 - 
    dot (V_35, N_34)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_37 = (_RGBias + (tmpvar_38 * _RGScale));
  rgColor_36.xyz = (tmpvar_37 * _RGColor).xyz;
  rgColor_36.w = _RGBloomFactor;
  mediump float tmpvar_39;
  tmpvar_39 = clamp (tmpvar_37, 0.0, 1.0);
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (outColor_5, rgColor_36, vec4((tmpvar_39 * _RGRatio)));
  tmpvar_33 = tmpvar_40;
  outColor_5.xyz = tmpvar_33.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD3;
    mediump float a_42;
    a_42 = xlv_TEXCOORD3.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  mediump float tmpvar_11;
  mediump vec3 N_12;
  N_12 = tmpvar_10;
  mediump vec3 L_13;
  L_13 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  tmpvar_11 = ((dot (N_12, L_13) * 0.4975) + 0.5);
  mediump vec3 N_14;
  N_14 = tmpvar_10;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_15 = _CustomLightDir.xyz;
  };
  tmpvar_5.x = ((dot (N_14, L_15) * 0.4975) + 0.5);
  tmpvar_5.y = _Opaqueness;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_6.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_COLOR2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
varying mediump vec2 xlv_COLOR2;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_7 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_7.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_7.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_7.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_5.xyz = diffColor_64;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  N_3 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (N_3, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_4.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_64 + color_69);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_74;
  color_74 = outColor_5.xyz;
  mediump vec3 tmpvar_75;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_75 = _lightProbColor.xyz;
  } else {
    tmpvar_75 = vec3(1.0, 1.0, 1.0);
  };
  color_74 = (outColor_5.xyz * tmpvar_75);
  outColor_5.xyz = color_74;
  mediump vec4 tmpvar_76;
  highp vec3 N_77;
  N_77 = N_3;
  highp vec3 V_78;
  V_78 = V_2;
  mediump vec4 rgColor_79;
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = pow (clamp ((1.001 - 
    dot (V_78, N_77)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_80 = (_RGBias + (tmpvar_81 * _RGScale));
  rgColor_79.xyz = (tmpvar_80 * _RGColor).xyz;
  rgColor_79.w = _RGBloomFactor;
  mediump float tmpvar_82;
  tmpvar_82 = clamp (tmpvar_80, 0.0, 1.0);
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (outColor_5, rgColor_79, vec4((tmpvar_82 * _RGRatio)));
  tmpvar_76 = tmpvar_83;
  outColor_5.xyz = tmpvar_76.xyz;
  outColor_5.w = xlv_COLOR2.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_84;
    scrpos_84 = xlv_TEXCOORD3;
    mediump float a_85;
    a_85 = xlv_TEXCOORD3.z;
    if ((a_85 < 0.95)) {
      scrpos_84.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_85 = (a_85 * 17.0);
      highp float tmpvar_86;
      tmpvar_86 = (scrpos_84.y / 4.0);
      highp float tmpvar_87;
      tmpvar_87 = (fract(abs(tmpvar_86)) * 4.0);
      highp float tmpvar_88;
      if ((tmpvar_86 >= 0.0)) {
        tmpvar_88 = tmpvar_87;
      } else {
        tmpvar_88 = -(tmpvar_87);
      };
      highp float tmpvar_89;
      tmpvar_89 = (scrpos_84.x / 4.0);
      highp float tmpvar_90;
      tmpvar_90 = (fract(abs(tmpvar_89)) * 4.0);
      highp float tmpvar_91;
      if ((tmpvar_89 >= 0.0)) {
        tmpvar_91 = tmpvar_90;
      } else {
        tmpvar_91 = -(tmpvar_90);
      };
      highp float x_92;
      x_92 = ((a_85 - _DITHERMATRIX[
        int(tmpvar_88)
      ][
        int(tmpvar_91)
      ]) - 0.01);
      if ((x_92 < 0.0)) {
        discard;
      };
    };
  };
  outColor_5.w = clamp (xlv_COLOR2.y, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.CharacterShaderEditorBase"
}