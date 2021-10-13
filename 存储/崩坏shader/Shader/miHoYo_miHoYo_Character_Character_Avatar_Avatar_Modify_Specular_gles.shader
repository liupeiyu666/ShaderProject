//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar_Modify_Specular" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
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
[KeywordEnum(Multi,Add)] _ModifySpec ("Modify Spec", Float) = 0
_ModifySpecMask ("Modify Specular Mask(R)", 2D) = "black" { }
_ModifySpecColor ("Modify Specular Color", Color) = (1,1,1,1)
_ModifySpecThreshold ("Modify Spec Threshold", Range(0, 1)) = 0.1
_MaxSpecGradient ("Max Spec Gradient", Range(0, 1)) = 1
_ModifySpecCoff ("Modify Spec Coff", Range(0, 10)) = 1
_ModifySpecPower ("Modify Spec Power", Range(0, 10)) = 1
[Toggle(LOOKUP_COLOR)] _LookupColor ("Lookup Color", Float) = 0
[Toggle(LOOKUP_COLOR_BILINEAR)] _LookupColorBilinear ("Lookup Color Bilinear", Float) = 0
_factorTex ("Factor Tex", 2D) = "white" { }
_indexTex ("Index Tex", 2D) = "white" { }
_tableTex ("Lookup Tex", 2D) = "white" { }
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
 LOD 200
 Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry" "Reflected" = "Reflected" "RenderType" = "Opaque" }
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry" "Reflected" = "Reflected" "RenderType" = "Opaque" }
  GpuProgramID 53298
Program "vp" {
SubProgram "gles hw_tier00 " {
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  outColor_6.xyz = color_28;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD3;
    mediump float a_31;
    a_31 = xlv_TEXCOORD3.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  outColor_6.xyz = color_28;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD3;
    mediump float a_31;
    a_31 = xlv_TEXCOORD3.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  outColor_6.xyz = color_28;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD3;
    mediump float a_31;
    a_31 = xlv_TEXCOORD3.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
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
Keywords { "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  outColor_6.xyz = color_28;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD3;
    mediump float a_31;
    a_31 = xlv_TEXCOORD3.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
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
Keywords { "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  outColor_6.xyz = color_28;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD3;
    mediump float a_31;
    a_31 = xlv_TEXCOORD3.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
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
Keywords { "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  outColor_6.xyz = color_28;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD3;
    mediump float a_31;
    a_31 = xlv_TEXCOORD3.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
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
Keywords { "LOOKUP_COLOR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_38;
  color_38 = outColor_5.xyz;
  mediump vec3 tmpvar_39;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_39 = _lightProbColor.xyz;
  } else {
    tmpvar_39 = vec3(1.0, 1.0, 1.0);
  };
  color_38 = (outColor_5.xyz * tmpvar_39);
  outColor_5.xyz = color_38;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_40;
    scrpos_40 = xlv_TEXCOORD3;
    mediump float a_41;
    a_41 = xlv_TEXCOORD3.z;
    if ((a_41 < 0.95)) {
      scrpos_40.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_41 = (a_41 * 17.0);
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_40.y / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_40.x / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float x_48;
      x_48 = ((a_41 - _DITHERMATRIX[
        int(tmpvar_44)
      ][
        int(tmpvar_47)
      ]) - 0.01);
      if ((x_48 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOOKUP_COLOR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_38;
  color_38 = outColor_5.xyz;
  mediump vec3 tmpvar_39;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_39 = _lightProbColor.xyz;
  } else {
    tmpvar_39 = vec3(1.0, 1.0, 1.0);
  };
  color_38 = (outColor_5.xyz * tmpvar_39);
  outColor_5.xyz = color_38;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_40;
    scrpos_40 = xlv_TEXCOORD3;
    mediump float a_41;
    a_41 = xlv_TEXCOORD3.z;
    if ((a_41 < 0.95)) {
      scrpos_40.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_41 = (a_41 * 17.0);
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_40.y / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_40.x / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float x_48;
      x_48 = ((a_41 - _DITHERMATRIX[
        int(tmpvar_44)
      ][
        int(tmpvar_47)
      ]) - 0.01);
      if ((x_48 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOOKUP_COLOR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_38;
  color_38 = outColor_5.xyz;
  mediump vec3 tmpvar_39;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_39 = _lightProbColor.xyz;
  } else {
    tmpvar_39 = vec3(1.0, 1.0, 1.0);
  };
  color_38 = (outColor_5.xyz * tmpvar_39);
  outColor_5.xyz = color_38;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_40;
    scrpos_40 = xlv_TEXCOORD3;
    mediump float a_41;
    a_41 = xlv_TEXCOORD3.z;
    if ((a_41 < 0.95)) {
      scrpos_40.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_41 = (a_41 * 17.0);
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_40.y / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_40.x / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float x_48;
      x_48 = ((a_41 - _DITHERMATRIX[
        int(tmpvar_44)
      ][
        int(tmpvar_47)
      ]) - 0.01);
      if ((x_48 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_81;
  color_81 = outColor_5.xyz;
  mediump vec3 tmpvar_82;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_82 = _lightProbColor.xyz;
  } else {
    tmpvar_82 = vec3(1.0, 1.0, 1.0);
  };
  color_81 = (outColor_5.xyz * tmpvar_82);
  outColor_5.xyz = color_81;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_83;
    scrpos_83 = xlv_TEXCOORD3;
    mediump float a_84;
    a_84 = xlv_TEXCOORD3.z;
    if ((a_84 < 0.95)) {
      scrpos_83.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_84 = (a_84 * 17.0);
      highp float tmpvar_85;
      tmpvar_85 = (scrpos_83.y / 4.0);
      highp float tmpvar_86;
      tmpvar_86 = (fract(abs(tmpvar_85)) * 4.0);
      highp float tmpvar_87;
      if ((tmpvar_85 >= 0.0)) {
        tmpvar_87 = tmpvar_86;
      } else {
        tmpvar_87 = -(tmpvar_86);
      };
      highp float tmpvar_88;
      tmpvar_88 = (scrpos_83.x / 4.0);
      highp float tmpvar_89;
      tmpvar_89 = (fract(abs(tmpvar_88)) * 4.0);
      highp float tmpvar_90;
      if ((tmpvar_88 >= 0.0)) {
        tmpvar_90 = tmpvar_89;
      } else {
        tmpvar_90 = -(tmpvar_89);
      };
      highp float x_91;
      x_91 = ((a_84 - _DITHERMATRIX[
        int(tmpvar_87)
      ][
        int(tmpvar_90)
      ]) - 0.01);
      if ((x_91 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_81;
  color_81 = outColor_5.xyz;
  mediump vec3 tmpvar_82;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_82 = _lightProbColor.xyz;
  } else {
    tmpvar_82 = vec3(1.0, 1.0, 1.0);
  };
  color_81 = (outColor_5.xyz * tmpvar_82);
  outColor_5.xyz = color_81;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_83;
    scrpos_83 = xlv_TEXCOORD3;
    mediump float a_84;
    a_84 = xlv_TEXCOORD3.z;
    if ((a_84 < 0.95)) {
      scrpos_83.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_84 = (a_84 * 17.0);
      highp float tmpvar_85;
      tmpvar_85 = (scrpos_83.y / 4.0);
      highp float tmpvar_86;
      tmpvar_86 = (fract(abs(tmpvar_85)) * 4.0);
      highp float tmpvar_87;
      if ((tmpvar_85 >= 0.0)) {
        tmpvar_87 = tmpvar_86;
      } else {
        tmpvar_87 = -(tmpvar_86);
      };
      highp float tmpvar_88;
      tmpvar_88 = (scrpos_83.x / 4.0);
      highp float tmpvar_89;
      tmpvar_89 = (fract(abs(tmpvar_88)) * 4.0);
      highp float tmpvar_90;
      if ((tmpvar_88 >= 0.0)) {
        tmpvar_90 = tmpvar_89;
      } else {
        tmpvar_90 = -(tmpvar_89);
      };
      highp float x_91;
      x_91 = ((a_84 - _DITHERMATRIX[
        int(tmpvar_87)
      ][
        int(tmpvar_90)
      ]) - 0.01);
      if ((x_91 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_81;
  color_81 = outColor_5.xyz;
  mediump vec3 tmpvar_82;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_82 = _lightProbColor.xyz;
  } else {
    tmpvar_82 = vec3(1.0, 1.0, 1.0);
  };
  color_81 = (outColor_5.xyz * tmpvar_82);
  outColor_5.xyz = color_81;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_83;
    scrpos_83 = xlv_TEXCOORD3;
    mediump float a_84;
    a_84 = xlv_TEXCOORD3.z;
    if ((a_84 < 0.95)) {
      scrpos_83.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_84 = (a_84 * 17.0);
      highp float tmpvar_85;
      tmpvar_85 = (scrpos_83.y / 4.0);
      highp float tmpvar_86;
      tmpvar_86 = (fract(abs(tmpvar_85)) * 4.0);
      highp float tmpvar_87;
      if ((tmpvar_85 >= 0.0)) {
        tmpvar_87 = tmpvar_86;
      } else {
        tmpvar_87 = -(tmpvar_86);
      };
      highp float tmpvar_88;
      tmpvar_88 = (scrpos_83.x / 4.0);
      highp float tmpvar_89;
      tmpvar_89 = (fract(abs(tmpvar_88)) * 4.0);
      highp float tmpvar_90;
      if ((tmpvar_88 >= 0.0)) {
        tmpvar_90 = tmpvar_89;
      } else {
        tmpvar_90 = -(tmpvar_89);
      };
      highp float x_91;
      x_91 = ((a_84 - _DITHERMATRIX[
        int(tmpvar_87)
      ][
        int(tmpvar_90)
      ]) - 0.01);
      if ((x_91 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  mediump vec3 tmpvar_30;
  highp vec3 N_31;
  N_31 = N_3;
  highp vec3 V_32;
  V_32 = V_2;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = pow (clamp ((1.001 - 
    dot (V_32, N_31)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_33 = (_RGBias + (tmpvar_34 * _RGScale));
  mediump vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_33 * _RGColor).xyz;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (tmpvar_33, 0.0, 1.0);
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (color_28, tmpvar_35, vec3((tmpvar_36 * _RGRatio)));
  tmpvar_30 = tmpvar_37;
  outColor_6.xyz = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD3;
    mediump float a_39;
    a_39 = xlv_TEXCOORD3.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
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
Keywords { "RIM_GLOW" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  mediump vec3 tmpvar_30;
  highp vec3 N_31;
  N_31 = N_3;
  highp vec3 V_32;
  V_32 = V_2;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = pow (clamp ((1.001 - 
    dot (V_32, N_31)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_33 = (_RGBias + (tmpvar_34 * _RGScale));
  mediump vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_33 * _RGColor).xyz;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (tmpvar_33, 0.0, 1.0);
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (color_28, tmpvar_35, vec3((tmpvar_36 * _RGRatio)));
  tmpvar_30 = tmpvar_37;
  outColor_6.xyz = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD3;
    mediump float a_39;
    a_39 = xlv_TEXCOORD3.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
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
Keywords { "RIM_GLOW" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  mediump vec3 tmpvar_30;
  highp vec3 N_31;
  N_31 = N_3;
  highp vec3 V_32;
  V_32 = V_2;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = pow (clamp ((1.001 - 
    dot (V_32, N_31)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_33 = (_RGBias + (tmpvar_34 * _RGScale));
  mediump vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_33 * _RGColor).xyz;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (tmpvar_33, 0.0, 1.0);
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (color_28, tmpvar_35, vec3((tmpvar_36 * _RGRatio)));
  tmpvar_30 = tmpvar_37;
  outColor_6.xyz = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD3;
    mediump float a_39;
    a_39 = xlv_TEXCOORD3.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
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
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  mediump vec3 tmpvar_30;
  highp vec3 N_31;
  N_31 = N_3;
  highp vec3 V_32;
  V_32 = V_2;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = pow (clamp ((1.001 - 
    dot (V_32, N_31)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_33 = (_RGBias + (tmpvar_34 * _RGScale));
  mediump vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_33 * _RGColor).xyz;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (tmpvar_33, 0.0, 1.0);
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (color_28, tmpvar_35, vec3((tmpvar_36 * _RGRatio)));
  tmpvar_30 = tmpvar_37;
  outColor_6.xyz = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD3;
    mediump float a_39;
    a_39 = xlv_TEXCOORD3.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
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
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  mediump vec3 tmpvar_30;
  highp vec3 N_31;
  N_31 = N_3;
  highp vec3 V_32;
  V_32 = V_2;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = pow (clamp ((1.001 - 
    dot (V_32, N_31)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_33 = (_RGBias + (tmpvar_34 * _RGScale));
  mediump vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_33 * _RGColor).xyz;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (tmpvar_33, 0.0, 1.0);
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (color_28, tmpvar_35, vec3((tmpvar_36 * _RGRatio)));
  tmpvar_30 = tmpvar_37;
  outColor_6.xyz = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD3;
    mediump float a_39;
    a_39 = xlv_TEXCOORD3.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
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
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  outColor_6.xyz = (outColor_6.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_28;
  color_28 = outColor_6.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_6.xyz * tmpvar_29);
  mediump vec3 tmpvar_30;
  highp vec3 N_31;
  N_31 = N_3;
  highp vec3 V_32;
  V_32 = V_2;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = pow (clamp ((1.001 - 
    dot (V_32, N_31)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_33 = (_RGBias + (tmpvar_34 * _RGScale));
  mediump vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_33 * _RGColor).xyz;
  mediump float tmpvar_36;
  tmpvar_36 = clamp (tmpvar_33, 0.0, 1.0);
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (color_28, tmpvar_35, vec3((tmpvar_36 * _RGRatio)));
  tmpvar_30 = tmpvar_37;
  outColor_6.xyz = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD3;
    mediump float a_39;
    a_39 = xlv_TEXCOORD3.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
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
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_38;
  color_38 = outColor_5.xyz;
  mediump vec3 tmpvar_39;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_39 = _lightProbColor.xyz;
  } else {
    tmpvar_39 = vec3(1.0, 1.0, 1.0);
  };
  color_38 = (outColor_5.xyz * tmpvar_39);
  mediump vec3 tmpvar_40;
  highp vec3 N_41;
  N_41 = N_3;
  highp vec3 V_42;
  V_42 = V_2;
  mediump float tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = pow (clamp ((1.001 - 
    dot (V_42, N_41)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_43 = (_RGBias + (tmpvar_44 * _RGScale));
  mediump vec3 tmpvar_45;
  tmpvar_45 = (tmpvar_43 * _RGColor).xyz;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (tmpvar_43, 0.0, 1.0);
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (color_38, tmpvar_45, vec3((tmpvar_46 * _RGRatio)));
  tmpvar_40 = tmpvar_47;
  outColor_5.xyz = tmpvar_40;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_48;
    scrpos_48 = xlv_TEXCOORD3;
    mediump float a_49;
    a_49 = xlv_TEXCOORD3.z;
    if ((a_49 < 0.95)) {
      scrpos_48.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_49 = (a_49 * 17.0);
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_48.y / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_48.x / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float x_56;
      x_56 = ((a_49 - _DITHERMATRIX[
        int(tmpvar_52)
      ][
        int(tmpvar_55)
      ]) - 0.01);
      if ((x_56 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_38;
  color_38 = outColor_5.xyz;
  mediump vec3 tmpvar_39;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_39 = _lightProbColor.xyz;
  } else {
    tmpvar_39 = vec3(1.0, 1.0, 1.0);
  };
  color_38 = (outColor_5.xyz * tmpvar_39);
  mediump vec3 tmpvar_40;
  highp vec3 N_41;
  N_41 = N_3;
  highp vec3 V_42;
  V_42 = V_2;
  mediump float tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = pow (clamp ((1.001 - 
    dot (V_42, N_41)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_43 = (_RGBias + (tmpvar_44 * _RGScale));
  mediump vec3 tmpvar_45;
  tmpvar_45 = (tmpvar_43 * _RGColor).xyz;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (tmpvar_43, 0.0, 1.0);
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (color_38, tmpvar_45, vec3((tmpvar_46 * _RGRatio)));
  tmpvar_40 = tmpvar_47;
  outColor_5.xyz = tmpvar_40;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_48;
    scrpos_48 = xlv_TEXCOORD3;
    mediump float a_49;
    a_49 = xlv_TEXCOORD3.z;
    if ((a_49 < 0.95)) {
      scrpos_48.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_49 = (a_49 * 17.0);
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_48.y / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_48.x / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float x_56;
      x_56 = ((a_49 - _DITHERMATRIX[
        int(tmpvar_52)
      ][
        int(tmpvar_55)
      ]) - 0.01);
      if ((x_56 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_38;
  color_38 = outColor_5.xyz;
  mediump vec3 tmpvar_39;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_39 = _lightProbColor.xyz;
  } else {
    tmpvar_39 = vec3(1.0, 1.0, 1.0);
  };
  color_38 = (outColor_5.xyz * tmpvar_39);
  mediump vec3 tmpvar_40;
  highp vec3 N_41;
  N_41 = N_3;
  highp vec3 V_42;
  V_42 = V_2;
  mediump float tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = pow (clamp ((1.001 - 
    dot (V_42, N_41)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_43 = (_RGBias + (tmpvar_44 * _RGScale));
  mediump vec3 tmpvar_45;
  tmpvar_45 = (tmpvar_43 * _RGColor).xyz;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (tmpvar_43, 0.0, 1.0);
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (color_38, tmpvar_45, vec3((tmpvar_46 * _RGRatio)));
  tmpvar_40 = tmpvar_47;
  outColor_5.xyz = tmpvar_40;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_48;
    scrpos_48 = xlv_TEXCOORD3;
    mediump float a_49;
    a_49 = xlv_TEXCOORD3.z;
    if ((a_49 < 0.95)) {
      scrpos_48.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_49 = (a_49 * 17.0);
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_48.y / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_48.x / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float x_56;
      x_56 = ((a_49 - _DITHERMATRIX[
        int(tmpvar_52)
      ][
        int(tmpvar_55)
      ]) - 0.01);
      if ((x_56 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_81;
  color_81 = outColor_5.xyz;
  mediump vec3 tmpvar_82;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_82 = _lightProbColor.xyz;
  } else {
    tmpvar_82 = vec3(1.0, 1.0, 1.0);
  };
  color_81 = (outColor_5.xyz * tmpvar_82);
  mediump vec3 tmpvar_83;
  highp vec3 N_84;
  N_84 = N_3;
  highp vec3 V_85;
  V_85 = V_2;
  mediump float tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = pow (clamp ((1.001 - 
    dot (V_85, N_84)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_86 = (_RGBias + (tmpvar_87 * _RGScale));
  mediump vec3 tmpvar_88;
  tmpvar_88 = (tmpvar_86 * _RGColor).xyz;
  mediump float tmpvar_89;
  tmpvar_89 = clamp (tmpvar_86, 0.0, 1.0);
  highp vec3 tmpvar_90;
  tmpvar_90 = mix (color_81, tmpvar_88, vec3((tmpvar_89 * _RGRatio)));
  tmpvar_83 = tmpvar_90;
  outColor_5.xyz = tmpvar_83;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_91;
    scrpos_91 = xlv_TEXCOORD3;
    mediump float a_92;
    a_92 = xlv_TEXCOORD3.z;
    if ((a_92 < 0.95)) {
      scrpos_91.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_92 = (a_92 * 17.0);
      highp float tmpvar_93;
      tmpvar_93 = (scrpos_91.y / 4.0);
      highp float tmpvar_94;
      tmpvar_94 = (fract(abs(tmpvar_93)) * 4.0);
      highp float tmpvar_95;
      if ((tmpvar_93 >= 0.0)) {
        tmpvar_95 = tmpvar_94;
      } else {
        tmpvar_95 = -(tmpvar_94);
      };
      highp float tmpvar_96;
      tmpvar_96 = (scrpos_91.x / 4.0);
      highp float tmpvar_97;
      tmpvar_97 = (fract(abs(tmpvar_96)) * 4.0);
      highp float tmpvar_98;
      if ((tmpvar_96 >= 0.0)) {
        tmpvar_98 = tmpvar_97;
      } else {
        tmpvar_98 = -(tmpvar_97);
      };
      highp float x_99;
      x_99 = ((a_92 - _DITHERMATRIX[
        int(tmpvar_95)
      ][
        int(tmpvar_98)
      ]) - 0.01);
      if ((x_99 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_81;
  color_81 = outColor_5.xyz;
  mediump vec3 tmpvar_82;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_82 = _lightProbColor.xyz;
  } else {
    tmpvar_82 = vec3(1.0, 1.0, 1.0);
  };
  color_81 = (outColor_5.xyz * tmpvar_82);
  mediump vec3 tmpvar_83;
  highp vec3 N_84;
  N_84 = N_3;
  highp vec3 V_85;
  V_85 = V_2;
  mediump float tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = pow (clamp ((1.001 - 
    dot (V_85, N_84)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_86 = (_RGBias + (tmpvar_87 * _RGScale));
  mediump vec3 tmpvar_88;
  tmpvar_88 = (tmpvar_86 * _RGColor).xyz;
  mediump float tmpvar_89;
  tmpvar_89 = clamp (tmpvar_86, 0.0, 1.0);
  highp vec3 tmpvar_90;
  tmpvar_90 = mix (color_81, tmpvar_88, vec3((tmpvar_89 * _RGRatio)));
  tmpvar_83 = tmpvar_90;
  outColor_5.xyz = tmpvar_83;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_91;
    scrpos_91 = xlv_TEXCOORD3;
    mediump float a_92;
    a_92 = xlv_TEXCOORD3.z;
    if ((a_92 < 0.95)) {
      scrpos_91.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_92 = (a_92 * 17.0);
      highp float tmpvar_93;
      tmpvar_93 = (scrpos_91.y / 4.0);
      highp float tmpvar_94;
      tmpvar_94 = (fract(abs(tmpvar_93)) * 4.0);
      highp float tmpvar_95;
      if ((tmpvar_93 >= 0.0)) {
        tmpvar_95 = tmpvar_94;
      } else {
        tmpvar_95 = -(tmpvar_94);
      };
      highp float tmpvar_96;
      tmpvar_96 = (scrpos_91.x / 4.0);
      highp float tmpvar_97;
      tmpvar_97 = (fract(abs(tmpvar_96)) * 4.0);
      highp float tmpvar_98;
      if ((tmpvar_96 >= 0.0)) {
        tmpvar_98 = tmpvar_97;
      } else {
        tmpvar_98 = -(tmpvar_97);
      };
      highp float x_99;
      x_99 = ((a_92 - _DITHERMATRIX[
        int(tmpvar_95)
      ][
        int(tmpvar_98)
      ]) - 0.01);
      if ((x_99 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_13.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_81;
  color_81 = outColor_5.xyz;
  mediump vec3 tmpvar_82;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_82 = _lightProbColor.xyz;
  } else {
    tmpvar_82 = vec3(1.0, 1.0, 1.0);
  };
  color_81 = (outColor_5.xyz * tmpvar_82);
  mediump vec3 tmpvar_83;
  highp vec3 N_84;
  N_84 = N_3;
  highp vec3 V_85;
  V_85 = V_2;
  mediump float tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = pow (clamp ((1.001 - 
    dot (V_85, N_84)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_86 = (_RGBias + (tmpvar_87 * _RGScale));
  mediump vec3 tmpvar_88;
  tmpvar_88 = (tmpvar_86 * _RGColor).xyz;
  mediump float tmpvar_89;
  tmpvar_89 = clamp (tmpvar_86, 0.0, 1.0);
  highp vec3 tmpvar_90;
  tmpvar_90 = mix (color_81, tmpvar_88, vec3((tmpvar_89 * _RGRatio)));
  tmpvar_83 = tmpvar_90;
  outColor_5.xyz = tmpvar_83;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_91;
    scrpos_91 = xlv_TEXCOORD3;
    mediump float a_92;
    a_92 = xlv_TEXCOORD3.z;
    if ((a_92 < 0.95)) {
      scrpos_91.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_92 = (a_92 * 17.0);
      highp float tmpvar_93;
      tmpvar_93 = (scrpos_91.y / 4.0);
      highp float tmpvar_94;
      tmpvar_94 = (fract(abs(tmpvar_93)) * 4.0);
      highp float tmpvar_95;
      if ((tmpvar_93 >= 0.0)) {
        tmpvar_95 = tmpvar_94;
      } else {
        tmpvar_95 = -(tmpvar_94);
      };
      highp float tmpvar_96;
      tmpvar_96 = (scrpos_91.x / 4.0);
      highp float tmpvar_97;
      tmpvar_97 = (fract(abs(tmpvar_96)) * 4.0);
      highp float tmpvar_98;
      if ((tmpvar_96 >= 0.0)) {
        tmpvar_98 = tmpvar_97;
      } else {
        tmpvar_98 = -(tmpvar_97);
      };
      highp float x_99;
      x_99 = ((a_92 - _DITHERMATRIX[
        int(tmpvar_95)
      ][
        int(tmpvar_98)
      ]) - 0.01);
      if ((x_99 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  outColor_6.xyz = color_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD3;
    mediump float a_46;
    a_46 = xlv_TEXCOORD3.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
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
Keywords { "SPECIAL_STATE" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  outColor_6.xyz = color_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD3;
    mediump float a_46;
    a_46 = xlv_TEXCOORD3.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
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
Keywords { "SPECIAL_STATE" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  outColor_6.xyz = color_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD3;
    mediump float a_46;
    a_46 = xlv_TEXCOORD3.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  outColor_6.xyz = color_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD3;
    mediump float a_46;
    a_46 = xlv_TEXCOORD3.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  outColor_6.xyz = color_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD3;
    mediump float a_46;
    a_46 = xlv_TEXCOORD3.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  outColor_6.xyz = color_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD3;
    mediump float a_46;
    a_46 = xlv_TEXCOORD3.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_38;
  mediump vec3 R_39;
  mediump float intensity_40;
  mediump vec4 noiseTex_41;
  mediump vec4 spColor_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_42.xyz = tmpvar_43.xyz;
  spColor_42.w = outColor_5.w;
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_41 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (((1.99 * noiseTex_41.x) * _SPNoiseScaler) - 1.0);
  intensity_40 = tmpvar_45;
  highp vec3 tmpvar_46;
  highp vec3 I_47;
  I_47 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_41 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_46 = (I_47 - (2.0 * (
    dot (N_3, I_47)
   * N_3)));
  R_39 = tmpvar_46;
  lowp vec3 tmpvar_48;
  tmpvar_48 = textureCube (_SPCubeMap, R_39).xyz;
  reflection_38 = tmpvar_48;
  highp vec3 tmpvar_49;
  mediump vec3 x_50;
  x_50 = (spColor_42.xyz * _SPOldColor.xyz);
  tmpvar_49 = mix (x_50, ((reflection_38 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_42.xyz = tmpvar_49;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_40 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_40 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_51;
      tmpvar_51 = mix (spColor_42, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_40) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_42 = tmpvar_51;
    };
  };
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (outColor_5.xyz, spColor_42.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_42.xyz = tmpvar_52;
  outColor_5.w = spColor_42.w;
  outColor_5.xyz = (spColor_42.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_53;
  color_53 = outColor_5.xyz;
  mediump vec3 tmpvar_54;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_54 = _lightProbColor.xyz;
  } else {
    tmpvar_54 = vec3(1.0, 1.0, 1.0);
  };
  color_53 = (outColor_5.xyz * tmpvar_54);
  outColor_5.xyz = color_53;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_55;
    scrpos_55 = xlv_TEXCOORD3;
    mediump float a_56;
    a_56 = xlv_TEXCOORD3.z;
    if ((a_56 < 0.95)) {
      scrpos_55.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_56 = (a_56 * 17.0);
      highp float tmpvar_57;
      tmpvar_57 = (scrpos_55.y / 4.0);
      highp float tmpvar_58;
      tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
      highp float tmpvar_59;
      if ((tmpvar_57 >= 0.0)) {
        tmpvar_59 = tmpvar_58;
      } else {
        tmpvar_59 = -(tmpvar_58);
      };
      highp float tmpvar_60;
      tmpvar_60 = (scrpos_55.x / 4.0);
      highp float tmpvar_61;
      tmpvar_61 = (fract(abs(tmpvar_60)) * 4.0);
      highp float tmpvar_62;
      if ((tmpvar_60 >= 0.0)) {
        tmpvar_62 = tmpvar_61;
      } else {
        tmpvar_62 = -(tmpvar_61);
      };
      highp float x_63;
      x_63 = ((a_56 - _DITHERMATRIX[
        int(tmpvar_59)
      ][
        int(tmpvar_62)
      ]) - 0.01);
      if ((x_63 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_38;
  mediump vec3 R_39;
  mediump float intensity_40;
  mediump vec4 noiseTex_41;
  mediump vec4 spColor_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_42.xyz = tmpvar_43.xyz;
  spColor_42.w = outColor_5.w;
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_41 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (((1.99 * noiseTex_41.x) * _SPNoiseScaler) - 1.0);
  intensity_40 = tmpvar_45;
  highp vec3 tmpvar_46;
  highp vec3 I_47;
  I_47 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_41 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_46 = (I_47 - (2.0 * (
    dot (N_3, I_47)
   * N_3)));
  R_39 = tmpvar_46;
  lowp vec3 tmpvar_48;
  tmpvar_48 = textureCube (_SPCubeMap, R_39).xyz;
  reflection_38 = tmpvar_48;
  highp vec3 tmpvar_49;
  mediump vec3 x_50;
  x_50 = (spColor_42.xyz * _SPOldColor.xyz);
  tmpvar_49 = mix (x_50, ((reflection_38 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_42.xyz = tmpvar_49;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_40 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_40 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_51;
      tmpvar_51 = mix (spColor_42, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_40) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_42 = tmpvar_51;
    };
  };
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (outColor_5.xyz, spColor_42.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_42.xyz = tmpvar_52;
  outColor_5.w = spColor_42.w;
  outColor_5.xyz = (spColor_42.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_53;
  color_53 = outColor_5.xyz;
  mediump vec3 tmpvar_54;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_54 = _lightProbColor.xyz;
  } else {
    tmpvar_54 = vec3(1.0, 1.0, 1.0);
  };
  color_53 = (outColor_5.xyz * tmpvar_54);
  outColor_5.xyz = color_53;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_55;
    scrpos_55 = xlv_TEXCOORD3;
    mediump float a_56;
    a_56 = xlv_TEXCOORD3.z;
    if ((a_56 < 0.95)) {
      scrpos_55.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_56 = (a_56 * 17.0);
      highp float tmpvar_57;
      tmpvar_57 = (scrpos_55.y / 4.0);
      highp float tmpvar_58;
      tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
      highp float tmpvar_59;
      if ((tmpvar_57 >= 0.0)) {
        tmpvar_59 = tmpvar_58;
      } else {
        tmpvar_59 = -(tmpvar_58);
      };
      highp float tmpvar_60;
      tmpvar_60 = (scrpos_55.x / 4.0);
      highp float tmpvar_61;
      tmpvar_61 = (fract(abs(tmpvar_60)) * 4.0);
      highp float tmpvar_62;
      if ((tmpvar_60 >= 0.0)) {
        tmpvar_62 = tmpvar_61;
      } else {
        tmpvar_62 = -(tmpvar_61);
      };
      highp float x_63;
      x_63 = ((a_56 - _DITHERMATRIX[
        int(tmpvar_59)
      ][
        int(tmpvar_62)
      ]) - 0.01);
      if ((x_63 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_38;
  mediump vec3 R_39;
  mediump float intensity_40;
  mediump vec4 noiseTex_41;
  mediump vec4 spColor_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_42.xyz = tmpvar_43.xyz;
  spColor_42.w = outColor_5.w;
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_41 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (((1.99 * noiseTex_41.x) * _SPNoiseScaler) - 1.0);
  intensity_40 = tmpvar_45;
  highp vec3 tmpvar_46;
  highp vec3 I_47;
  I_47 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_41 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_46 = (I_47 - (2.0 * (
    dot (N_3, I_47)
   * N_3)));
  R_39 = tmpvar_46;
  lowp vec3 tmpvar_48;
  tmpvar_48 = textureCube (_SPCubeMap, R_39).xyz;
  reflection_38 = tmpvar_48;
  highp vec3 tmpvar_49;
  mediump vec3 x_50;
  x_50 = (spColor_42.xyz * _SPOldColor.xyz);
  tmpvar_49 = mix (x_50, ((reflection_38 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_42.xyz = tmpvar_49;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_40 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_40 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_51;
      tmpvar_51 = mix (spColor_42, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_40) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_42 = tmpvar_51;
    };
  };
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (outColor_5.xyz, spColor_42.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_42.xyz = tmpvar_52;
  outColor_5.w = spColor_42.w;
  outColor_5.xyz = (spColor_42.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_53;
  color_53 = outColor_5.xyz;
  mediump vec3 tmpvar_54;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_54 = _lightProbColor.xyz;
  } else {
    tmpvar_54 = vec3(1.0, 1.0, 1.0);
  };
  color_53 = (outColor_5.xyz * tmpvar_54);
  outColor_5.xyz = color_53;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_55;
    scrpos_55 = xlv_TEXCOORD3;
    mediump float a_56;
    a_56 = xlv_TEXCOORD3.z;
    if ((a_56 < 0.95)) {
      scrpos_55.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_56 = (a_56 * 17.0);
      highp float tmpvar_57;
      tmpvar_57 = (scrpos_55.y / 4.0);
      highp float tmpvar_58;
      tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
      highp float tmpvar_59;
      if ((tmpvar_57 >= 0.0)) {
        tmpvar_59 = tmpvar_58;
      } else {
        tmpvar_59 = -(tmpvar_58);
      };
      highp float tmpvar_60;
      tmpvar_60 = (scrpos_55.x / 4.0);
      highp float tmpvar_61;
      tmpvar_61 = (fract(abs(tmpvar_60)) * 4.0);
      highp float tmpvar_62;
      if ((tmpvar_60 >= 0.0)) {
        tmpvar_62 = tmpvar_61;
      } else {
        tmpvar_62 = -(tmpvar_61);
      };
      highp float x_63;
      x_63 = ((a_56 - _DITHERMATRIX[
        int(tmpvar_59)
      ][
        int(tmpvar_62)
      ]) - 0.01);
      if ((x_63 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_81;
  mediump vec3 R_82;
  mediump float intensity_83;
  mediump vec4 noiseTex_84;
  mediump vec4 spColor_85;
  lowp vec4 tmpvar_86;
  tmpvar_86 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_85.xyz = tmpvar_86.xyz;
  spColor_85.w = outColor_5.w;
  lowp vec4 tmpvar_87;
  tmpvar_87 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_84 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (((1.99 * noiseTex_84.x) * _SPNoiseScaler) - 1.0);
  intensity_83 = tmpvar_88;
  highp vec3 tmpvar_89;
  highp vec3 I_90;
  I_90 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_84 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_89 = (I_90 - (2.0 * (
    dot (N_3, I_90)
   * N_3)));
  R_82 = tmpvar_89;
  lowp vec3 tmpvar_91;
  tmpvar_91 = textureCube (_SPCubeMap, R_82).xyz;
  reflection_81 = tmpvar_91;
  highp vec3 tmpvar_92;
  mediump vec3 x_93;
  x_93 = (spColor_85.xyz * _SPOldColor.xyz);
  tmpvar_92 = mix (x_93, ((reflection_81 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_85.xyz = tmpvar_92;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_83 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_83 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_94;
      tmpvar_94 = mix (spColor_85, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_83) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_85 = tmpvar_94;
    };
  };
  highp vec3 tmpvar_95;
  tmpvar_95 = mix (outColor_5.xyz, spColor_85.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_85.xyz = tmpvar_95;
  outColor_5.w = spColor_85.w;
  outColor_5.xyz = (spColor_85.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_96;
  color_96 = outColor_5.xyz;
  mediump vec3 tmpvar_97;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_97 = _lightProbColor.xyz;
  } else {
    tmpvar_97 = vec3(1.0, 1.0, 1.0);
  };
  color_96 = (outColor_5.xyz * tmpvar_97);
  outColor_5.xyz = color_96;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_98;
    scrpos_98 = xlv_TEXCOORD3;
    mediump float a_99;
    a_99 = xlv_TEXCOORD3.z;
    if ((a_99 < 0.95)) {
      scrpos_98.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_99 = (a_99 * 17.0);
      highp float tmpvar_100;
      tmpvar_100 = (scrpos_98.y / 4.0);
      highp float tmpvar_101;
      tmpvar_101 = (fract(abs(tmpvar_100)) * 4.0);
      highp float tmpvar_102;
      if ((tmpvar_100 >= 0.0)) {
        tmpvar_102 = tmpvar_101;
      } else {
        tmpvar_102 = -(tmpvar_101);
      };
      highp float tmpvar_103;
      tmpvar_103 = (scrpos_98.x / 4.0);
      highp float tmpvar_104;
      tmpvar_104 = (fract(abs(tmpvar_103)) * 4.0);
      highp float tmpvar_105;
      if ((tmpvar_103 >= 0.0)) {
        tmpvar_105 = tmpvar_104;
      } else {
        tmpvar_105 = -(tmpvar_104);
      };
      highp float x_106;
      x_106 = ((a_99 - _DITHERMATRIX[
        int(tmpvar_102)
      ][
        int(tmpvar_105)
      ]) - 0.01);
      if ((x_106 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_81;
  mediump vec3 R_82;
  mediump float intensity_83;
  mediump vec4 noiseTex_84;
  mediump vec4 spColor_85;
  lowp vec4 tmpvar_86;
  tmpvar_86 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_85.xyz = tmpvar_86.xyz;
  spColor_85.w = outColor_5.w;
  lowp vec4 tmpvar_87;
  tmpvar_87 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_84 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (((1.99 * noiseTex_84.x) * _SPNoiseScaler) - 1.0);
  intensity_83 = tmpvar_88;
  highp vec3 tmpvar_89;
  highp vec3 I_90;
  I_90 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_84 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_89 = (I_90 - (2.0 * (
    dot (N_3, I_90)
   * N_3)));
  R_82 = tmpvar_89;
  lowp vec3 tmpvar_91;
  tmpvar_91 = textureCube (_SPCubeMap, R_82).xyz;
  reflection_81 = tmpvar_91;
  highp vec3 tmpvar_92;
  mediump vec3 x_93;
  x_93 = (spColor_85.xyz * _SPOldColor.xyz);
  tmpvar_92 = mix (x_93, ((reflection_81 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_85.xyz = tmpvar_92;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_83 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_83 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_94;
      tmpvar_94 = mix (spColor_85, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_83) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_85 = tmpvar_94;
    };
  };
  highp vec3 tmpvar_95;
  tmpvar_95 = mix (outColor_5.xyz, spColor_85.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_85.xyz = tmpvar_95;
  outColor_5.w = spColor_85.w;
  outColor_5.xyz = (spColor_85.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_96;
  color_96 = outColor_5.xyz;
  mediump vec3 tmpvar_97;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_97 = _lightProbColor.xyz;
  } else {
    tmpvar_97 = vec3(1.0, 1.0, 1.0);
  };
  color_96 = (outColor_5.xyz * tmpvar_97);
  outColor_5.xyz = color_96;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_98;
    scrpos_98 = xlv_TEXCOORD3;
    mediump float a_99;
    a_99 = xlv_TEXCOORD3.z;
    if ((a_99 < 0.95)) {
      scrpos_98.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_99 = (a_99 * 17.0);
      highp float tmpvar_100;
      tmpvar_100 = (scrpos_98.y / 4.0);
      highp float tmpvar_101;
      tmpvar_101 = (fract(abs(tmpvar_100)) * 4.0);
      highp float tmpvar_102;
      if ((tmpvar_100 >= 0.0)) {
        tmpvar_102 = tmpvar_101;
      } else {
        tmpvar_102 = -(tmpvar_101);
      };
      highp float tmpvar_103;
      tmpvar_103 = (scrpos_98.x / 4.0);
      highp float tmpvar_104;
      tmpvar_104 = (fract(abs(tmpvar_103)) * 4.0);
      highp float tmpvar_105;
      if ((tmpvar_103 >= 0.0)) {
        tmpvar_105 = tmpvar_104;
      } else {
        tmpvar_105 = -(tmpvar_104);
      };
      highp float x_106;
      x_106 = ((a_99 - _DITHERMATRIX[
        int(tmpvar_102)
      ][
        int(tmpvar_105)
      ]) - 0.01);
      if ((x_106 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_81;
  mediump vec3 R_82;
  mediump float intensity_83;
  mediump vec4 noiseTex_84;
  mediump vec4 spColor_85;
  lowp vec4 tmpvar_86;
  tmpvar_86 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_85.xyz = tmpvar_86.xyz;
  spColor_85.w = outColor_5.w;
  lowp vec4 tmpvar_87;
  tmpvar_87 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_84 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (((1.99 * noiseTex_84.x) * _SPNoiseScaler) - 1.0);
  intensity_83 = tmpvar_88;
  highp vec3 tmpvar_89;
  highp vec3 I_90;
  I_90 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_84 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_89 = (I_90 - (2.0 * (
    dot (N_3, I_90)
   * N_3)));
  R_82 = tmpvar_89;
  lowp vec3 tmpvar_91;
  tmpvar_91 = textureCube (_SPCubeMap, R_82).xyz;
  reflection_81 = tmpvar_91;
  highp vec3 tmpvar_92;
  mediump vec3 x_93;
  x_93 = (spColor_85.xyz * _SPOldColor.xyz);
  tmpvar_92 = mix (x_93, ((reflection_81 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_85.xyz = tmpvar_92;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_83 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_83 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_94;
      tmpvar_94 = mix (spColor_85, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_83) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_85 = tmpvar_94;
    };
  };
  highp vec3 tmpvar_95;
  tmpvar_95 = mix (outColor_5.xyz, spColor_85.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_85.xyz = tmpvar_95;
  outColor_5.w = spColor_85.w;
  outColor_5.xyz = (spColor_85.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_96;
  color_96 = outColor_5.xyz;
  mediump vec3 tmpvar_97;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_97 = _lightProbColor.xyz;
  } else {
    tmpvar_97 = vec3(1.0, 1.0, 1.0);
  };
  color_96 = (outColor_5.xyz * tmpvar_97);
  outColor_5.xyz = color_96;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_98;
    scrpos_98 = xlv_TEXCOORD3;
    mediump float a_99;
    a_99 = xlv_TEXCOORD3.z;
    if ((a_99 < 0.95)) {
      scrpos_98.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_99 = (a_99 * 17.0);
      highp float tmpvar_100;
      tmpvar_100 = (scrpos_98.y / 4.0);
      highp float tmpvar_101;
      tmpvar_101 = (fract(abs(tmpvar_100)) * 4.0);
      highp float tmpvar_102;
      if ((tmpvar_100 >= 0.0)) {
        tmpvar_102 = tmpvar_101;
      } else {
        tmpvar_102 = -(tmpvar_101);
      };
      highp float tmpvar_103;
      tmpvar_103 = (scrpos_98.x / 4.0);
      highp float tmpvar_104;
      tmpvar_104 = (fract(abs(tmpvar_103)) * 4.0);
      highp float tmpvar_105;
      if ((tmpvar_103 >= 0.0)) {
        tmpvar_105 = tmpvar_104;
      } else {
        tmpvar_105 = -(tmpvar_104);
      };
      highp float x_106;
      x_106 = ((a_99 - _DITHERMATRIX[
        int(tmpvar_102)
      ][
        int(tmpvar_105)
      ]) - 0.01);
      if ((x_106 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  mediump vec3 tmpvar_45;
  highp vec3 N_46;
  N_46 = N_3;
  highp vec3 V_47;
  V_47 = V_2;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = pow (clamp ((1.001 - 
    dot (V_47, N_46)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_48 = (_RGBias + (tmpvar_49 * _RGScale));
  mediump vec3 tmpvar_50;
  tmpvar_50 = (tmpvar_48 * _RGColor).xyz;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (tmpvar_48, 0.0, 1.0);
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (color_43, tmpvar_50, vec3((tmpvar_51 * _RGRatio)));
  tmpvar_45 = tmpvar_52;
  outColor_6.xyz = tmpvar_45;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_53;
    scrpos_53 = xlv_TEXCOORD3;
    mediump float a_54;
    a_54 = xlv_TEXCOORD3.z;
    if ((a_54 < 0.95)) {
      scrpos_53.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_54 = (a_54 * 17.0);
      highp float tmpvar_55;
      tmpvar_55 = (scrpos_53.y / 4.0);
      highp float tmpvar_56;
      tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
      highp float tmpvar_57;
      if ((tmpvar_55 >= 0.0)) {
        tmpvar_57 = tmpvar_56;
      } else {
        tmpvar_57 = -(tmpvar_56);
      };
      highp float tmpvar_58;
      tmpvar_58 = (scrpos_53.x / 4.0);
      highp float tmpvar_59;
      tmpvar_59 = (fract(abs(tmpvar_58)) * 4.0);
      highp float tmpvar_60;
      if ((tmpvar_58 >= 0.0)) {
        tmpvar_60 = tmpvar_59;
      } else {
        tmpvar_60 = -(tmpvar_59);
      };
      highp float x_61;
      x_61 = ((a_54 - _DITHERMATRIX[
        int(tmpvar_57)
      ][
        int(tmpvar_60)
      ]) - 0.01);
      if ((x_61 < 0.0)) {
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  mediump vec3 tmpvar_45;
  highp vec3 N_46;
  N_46 = N_3;
  highp vec3 V_47;
  V_47 = V_2;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = pow (clamp ((1.001 - 
    dot (V_47, N_46)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_48 = (_RGBias + (tmpvar_49 * _RGScale));
  mediump vec3 tmpvar_50;
  tmpvar_50 = (tmpvar_48 * _RGColor).xyz;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (tmpvar_48, 0.0, 1.0);
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (color_43, tmpvar_50, vec3((tmpvar_51 * _RGRatio)));
  tmpvar_45 = tmpvar_52;
  outColor_6.xyz = tmpvar_45;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_53;
    scrpos_53 = xlv_TEXCOORD3;
    mediump float a_54;
    a_54 = xlv_TEXCOORD3.z;
    if ((a_54 < 0.95)) {
      scrpos_53.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_54 = (a_54 * 17.0);
      highp float tmpvar_55;
      tmpvar_55 = (scrpos_53.y / 4.0);
      highp float tmpvar_56;
      tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
      highp float tmpvar_57;
      if ((tmpvar_55 >= 0.0)) {
        tmpvar_57 = tmpvar_56;
      } else {
        tmpvar_57 = -(tmpvar_56);
      };
      highp float tmpvar_58;
      tmpvar_58 = (scrpos_53.x / 4.0);
      highp float tmpvar_59;
      tmpvar_59 = (fract(abs(tmpvar_58)) * 4.0);
      highp float tmpvar_60;
      if ((tmpvar_58 >= 0.0)) {
        tmpvar_60 = tmpvar_59;
      } else {
        tmpvar_60 = -(tmpvar_59);
      };
      highp float x_61;
      x_61 = ((a_54 - _DITHERMATRIX[
        int(tmpvar_57)
      ][
        int(tmpvar_60)
      ]) - 0.01);
      if ((x_61 < 0.0)) {
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  mediump vec3 tmpvar_45;
  highp vec3 N_46;
  N_46 = N_3;
  highp vec3 V_47;
  V_47 = V_2;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = pow (clamp ((1.001 - 
    dot (V_47, N_46)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_48 = (_RGBias + (tmpvar_49 * _RGScale));
  mediump vec3 tmpvar_50;
  tmpvar_50 = (tmpvar_48 * _RGColor).xyz;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (tmpvar_48, 0.0, 1.0);
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (color_43, tmpvar_50, vec3((tmpvar_51 * _RGRatio)));
  tmpvar_45 = tmpvar_52;
  outColor_6.xyz = tmpvar_45;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_53;
    scrpos_53 = xlv_TEXCOORD3;
    mediump float a_54;
    a_54 = xlv_TEXCOORD3.z;
    if ((a_54 < 0.95)) {
      scrpos_53.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_54 = (a_54 * 17.0);
      highp float tmpvar_55;
      tmpvar_55 = (scrpos_53.y / 4.0);
      highp float tmpvar_56;
      tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
      highp float tmpvar_57;
      if ((tmpvar_55 >= 0.0)) {
        tmpvar_57 = tmpvar_56;
      } else {
        tmpvar_57 = -(tmpvar_56);
      };
      highp float tmpvar_58;
      tmpvar_58 = (scrpos_53.x / 4.0);
      highp float tmpvar_59;
      tmpvar_59 = (fract(abs(tmpvar_58)) * 4.0);
      highp float tmpvar_60;
      if ((tmpvar_58 >= 0.0)) {
        tmpvar_60 = tmpvar_59;
      } else {
        tmpvar_60 = -(tmpvar_59);
      };
      highp float x_61;
      x_61 = ((a_54 - _DITHERMATRIX[
        int(tmpvar_57)
      ][
        int(tmpvar_60)
      ]) - 0.01);
      if ((x_61 < 0.0)) {
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  mediump vec3 tmpvar_45;
  highp vec3 N_46;
  N_46 = N_3;
  highp vec3 V_47;
  V_47 = V_2;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = pow (clamp ((1.001 - 
    dot (V_47, N_46)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_48 = (_RGBias + (tmpvar_49 * _RGScale));
  mediump vec3 tmpvar_50;
  tmpvar_50 = (tmpvar_48 * _RGColor).xyz;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (tmpvar_48, 0.0, 1.0);
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (color_43, tmpvar_50, vec3((tmpvar_51 * _RGRatio)));
  tmpvar_45 = tmpvar_52;
  outColor_6.xyz = tmpvar_45;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_53;
    scrpos_53 = xlv_TEXCOORD3;
    mediump float a_54;
    a_54 = xlv_TEXCOORD3.z;
    if ((a_54 < 0.95)) {
      scrpos_53.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_54 = (a_54 * 17.0);
      highp float tmpvar_55;
      tmpvar_55 = (scrpos_53.y / 4.0);
      highp float tmpvar_56;
      tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
      highp float tmpvar_57;
      if ((tmpvar_55 >= 0.0)) {
        tmpvar_57 = tmpvar_56;
      } else {
        tmpvar_57 = -(tmpvar_56);
      };
      highp float tmpvar_58;
      tmpvar_58 = (scrpos_53.x / 4.0);
      highp float tmpvar_59;
      tmpvar_59 = (fract(abs(tmpvar_58)) * 4.0);
      highp float tmpvar_60;
      if ((tmpvar_58 >= 0.0)) {
        tmpvar_60 = tmpvar_59;
      } else {
        tmpvar_60 = -(tmpvar_59);
      };
      highp float x_61;
      x_61 = ((a_54 - _DITHERMATRIX[
        int(tmpvar_57)
      ][
        int(tmpvar_60)
      ]) - 0.01);
      if ((x_61 < 0.0)) {
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  mediump vec3 tmpvar_45;
  highp vec3 N_46;
  N_46 = N_3;
  highp vec3 V_47;
  V_47 = V_2;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = pow (clamp ((1.001 - 
    dot (V_47, N_46)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_48 = (_RGBias + (tmpvar_49 * _RGScale));
  mediump vec3 tmpvar_50;
  tmpvar_50 = (tmpvar_48 * _RGColor).xyz;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (tmpvar_48, 0.0, 1.0);
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (color_43, tmpvar_50, vec3((tmpvar_51 * _RGRatio)));
  tmpvar_45 = tmpvar_52;
  outColor_6.xyz = tmpvar_45;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_53;
    scrpos_53 = xlv_TEXCOORD3;
    mediump float a_54;
    a_54 = xlv_TEXCOORD3.z;
    if ((a_54 < 0.95)) {
      scrpos_53.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_54 = (a_54 * 17.0);
      highp float tmpvar_55;
      tmpvar_55 = (scrpos_53.y / 4.0);
      highp float tmpvar_56;
      tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
      highp float tmpvar_57;
      if ((tmpvar_55 >= 0.0)) {
        tmpvar_57 = tmpvar_56;
      } else {
        tmpvar_57 = -(tmpvar_56);
      };
      highp float tmpvar_58;
      tmpvar_58 = (scrpos_53.x / 4.0);
      highp float tmpvar_59;
      tmpvar_59 = (fract(abs(tmpvar_58)) * 4.0);
      highp float tmpvar_60;
      if ((tmpvar_58 >= 0.0)) {
        tmpvar_60 = tmpvar_59;
      } else {
        tmpvar_60 = -(tmpvar_59);
      };
      highp float x_61;
      x_61 = ((a_54 - _DITHERMATRIX[
        int(tmpvar_57)
      ][
        int(tmpvar_60)
      ]) - 0.01);
      if ((x_61 < 0.0)) {
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_21 >= _ModifySpecThreshold)) {
      mediump float attenuate_22;
      attenuate_22 = 1.0;
      if ((tmpvar_21 < _MaxSpecGradient)) {
        attenuate_22 = pow (((tmpvar_21 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_6.xyz = (outColor_6.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_23.x)
       * attenuate_22)));
    };
  } else {
    mediump vec3 color_24;
    color_24 = _ModifySpecColor.xyz;
    mediump float tmpvar_25;
    tmpvar_25 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_25 >= _ModifySpecThreshold)) {
      if ((tmpvar_25 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_26;
        tmpvar_26.w = 0.0;
        tmpvar_26.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_27;
        tmpvar_27 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_24 = ((_ModifySpecCoff * mix (tmpvar_26, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_25 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_27.x).xyz;
      };
    } else {
      color_24 = vec3(1.0, 1.0, 1.0);
    };
    outColor_6.xyz = (outColor_6.xyz * color_24);
  };
  outColor_6.w = _BloomFactor;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_6.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_3, I_37)
   * N_3)));
  R_29 = tmpvar_36;
  lowp vec3 tmpvar_38;
  tmpvar_38 = textureCube (_SPCubeMap, R_29).xyz;
  reflection_28 = tmpvar_38;
  highp vec3 tmpvar_39;
  mediump vec3 x_40;
  x_40 = (spColor_32.xyz * _SPOldColor.xyz);
  tmpvar_39 = mix (x_40, ((reflection_28 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_32.xyz = tmpvar_39;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_30 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_30 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_41;
      tmpvar_41 = mix (spColor_32, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_30) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_32 = tmpvar_41;
    };
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_6.xyz, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_6.w = spColor_32.w;
  outColor_6.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_43;
  color_43 = outColor_6.xyz;
  mediump vec3 tmpvar_44;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_44 = _lightProbColor.xyz;
  } else {
    tmpvar_44 = vec3(1.0, 1.0, 1.0);
  };
  color_43 = (outColor_6.xyz * tmpvar_44);
  mediump vec3 tmpvar_45;
  highp vec3 N_46;
  N_46 = N_3;
  highp vec3 V_47;
  V_47 = V_2;
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = pow (clamp ((1.001 - 
    dot (V_47, N_46)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_48 = (_RGBias + (tmpvar_49 * _RGScale));
  mediump vec3 tmpvar_50;
  tmpvar_50 = (tmpvar_48 * _RGColor).xyz;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (tmpvar_48, 0.0, 1.0);
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (color_43, tmpvar_50, vec3((tmpvar_51 * _RGRatio)));
  tmpvar_45 = tmpvar_52;
  outColor_6.xyz = tmpvar_45;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_53;
    scrpos_53 = xlv_TEXCOORD3;
    mediump float a_54;
    a_54 = xlv_TEXCOORD3.z;
    if ((a_54 < 0.95)) {
      scrpos_53.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_54 = (a_54 * 17.0);
      highp float tmpvar_55;
      tmpvar_55 = (scrpos_53.y / 4.0);
      highp float tmpvar_56;
      tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
      highp float tmpvar_57;
      if ((tmpvar_55 >= 0.0)) {
        tmpvar_57 = tmpvar_56;
      } else {
        tmpvar_57 = -(tmpvar_56);
      };
      highp float tmpvar_58;
      tmpvar_58 = (scrpos_53.x / 4.0);
      highp float tmpvar_59;
      tmpvar_59 = (fract(abs(tmpvar_58)) * 4.0);
      highp float tmpvar_60;
      if ((tmpvar_58 >= 0.0)) {
        tmpvar_60 = tmpvar_59;
      } else {
        tmpvar_60 = -(tmpvar_59);
      };
      highp float x_61;
      x_61 = ((a_54 - _DITHERMATRIX[
        int(tmpvar_57)
      ][
        int(tmpvar_60)
      ]) - 0.01);
      if ((x_61 < 0.0)) {
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_38;
  mediump vec3 R_39;
  mediump float intensity_40;
  mediump vec4 noiseTex_41;
  mediump vec4 spColor_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_42.xyz = tmpvar_43.xyz;
  spColor_42.w = outColor_5.w;
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_41 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (((1.99 * noiseTex_41.x) * _SPNoiseScaler) - 1.0);
  intensity_40 = tmpvar_45;
  highp vec3 tmpvar_46;
  highp vec3 I_47;
  I_47 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_41 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_46 = (I_47 - (2.0 * (
    dot (N_3, I_47)
   * N_3)));
  R_39 = tmpvar_46;
  lowp vec3 tmpvar_48;
  tmpvar_48 = textureCube (_SPCubeMap, R_39).xyz;
  reflection_38 = tmpvar_48;
  highp vec3 tmpvar_49;
  mediump vec3 x_50;
  x_50 = (spColor_42.xyz * _SPOldColor.xyz);
  tmpvar_49 = mix (x_50, ((reflection_38 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_42.xyz = tmpvar_49;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_40 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_40 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_51;
      tmpvar_51 = mix (spColor_42, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_40) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_42 = tmpvar_51;
    };
  };
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (outColor_5.xyz, spColor_42.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_42.xyz = tmpvar_52;
  outColor_5.w = spColor_42.w;
  outColor_5.xyz = (spColor_42.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_53;
  color_53 = outColor_5.xyz;
  mediump vec3 tmpvar_54;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_54 = _lightProbColor.xyz;
  } else {
    tmpvar_54 = vec3(1.0, 1.0, 1.0);
  };
  color_53 = (outColor_5.xyz * tmpvar_54);
  mediump vec3 tmpvar_55;
  highp vec3 N_56;
  N_56 = N_3;
  highp vec3 V_57;
  V_57 = V_2;
  mediump float tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = pow (clamp ((1.001 - 
    dot (V_57, N_56)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_58 = (_RGBias + (tmpvar_59 * _RGScale));
  mediump vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_58 * _RGColor).xyz;
  mediump float tmpvar_61;
  tmpvar_61 = clamp (tmpvar_58, 0.0, 1.0);
  highp vec3 tmpvar_62;
  tmpvar_62 = mix (color_53, tmpvar_60, vec3((tmpvar_61 * _RGRatio)));
  tmpvar_55 = tmpvar_62;
  outColor_5.xyz = tmpvar_55;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_63;
    scrpos_63 = xlv_TEXCOORD3;
    mediump float a_64;
    a_64 = xlv_TEXCOORD3.z;
    if ((a_64 < 0.95)) {
      scrpos_63.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_64 = (a_64 * 17.0);
      highp float tmpvar_65;
      tmpvar_65 = (scrpos_63.y / 4.0);
      highp float tmpvar_66;
      tmpvar_66 = (fract(abs(tmpvar_65)) * 4.0);
      highp float tmpvar_67;
      if ((tmpvar_65 >= 0.0)) {
        tmpvar_67 = tmpvar_66;
      } else {
        tmpvar_67 = -(tmpvar_66);
      };
      highp float tmpvar_68;
      tmpvar_68 = (scrpos_63.x / 4.0);
      highp float tmpvar_69;
      tmpvar_69 = (fract(abs(tmpvar_68)) * 4.0);
      highp float tmpvar_70;
      if ((tmpvar_68 >= 0.0)) {
        tmpvar_70 = tmpvar_69;
      } else {
        tmpvar_70 = -(tmpvar_69);
      };
      highp float x_71;
      x_71 = ((a_64 - _DITHERMATRIX[
        int(tmpvar_67)
      ][
        int(tmpvar_70)
      ]) - 0.01);
      if ((x_71 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_38;
  mediump vec3 R_39;
  mediump float intensity_40;
  mediump vec4 noiseTex_41;
  mediump vec4 spColor_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_42.xyz = tmpvar_43.xyz;
  spColor_42.w = outColor_5.w;
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_41 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (((1.99 * noiseTex_41.x) * _SPNoiseScaler) - 1.0);
  intensity_40 = tmpvar_45;
  highp vec3 tmpvar_46;
  highp vec3 I_47;
  I_47 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_41 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_46 = (I_47 - (2.0 * (
    dot (N_3, I_47)
   * N_3)));
  R_39 = tmpvar_46;
  lowp vec3 tmpvar_48;
  tmpvar_48 = textureCube (_SPCubeMap, R_39).xyz;
  reflection_38 = tmpvar_48;
  highp vec3 tmpvar_49;
  mediump vec3 x_50;
  x_50 = (spColor_42.xyz * _SPOldColor.xyz);
  tmpvar_49 = mix (x_50, ((reflection_38 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_42.xyz = tmpvar_49;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_40 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_40 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_51;
      tmpvar_51 = mix (spColor_42, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_40) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_42 = tmpvar_51;
    };
  };
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (outColor_5.xyz, spColor_42.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_42.xyz = tmpvar_52;
  outColor_5.w = spColor_42.w;
  outColor_5.xyz = (spColor_42.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_53;
  color_53 = outColor_5.xyz;
  mediump vec3 tmpvar_54;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_54 = _lightProbColor.xyz;
  } else {
    tmpvar_54 = vec3(1.0, 1.0, 1.0);
  };
  color_53 = (outColor_5.xyz * tmpvar_54);
  mediump vec3 tmpvar_55;
  highp vec3 N_56;
  N_56 = N_3;
  highp vec3 V_57;
  V_57 = V_2;
  mediump float tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = pow (clamp ((1.001 - 
    dot (V_57, N_56)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_58 = (_RGBias + (tmpvar_59 * _RGScale));
  mediump vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_58 * _RGColor).xyz;
  mediump float tmpvar_61;
  tmpvar_61 = clamp (tmpvar_58, 0.0, 1.0);
  highp vec3 tmpvar_62;
  tmpvar_62 = mix (color_53, tmpvar_60, vec3((tmpvar_61 * _RGRatio)));
  tmpvar_55 = tmpvar_62;
  outColor_5.xyz = tmpvar_55;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_63;
    scrpos_63 = xlv_TEXCOORD3;
    mediump float a_64;
    a_64 = xlv_TEXCOORD3.z;
    if ((a_64 < 0.95)) {
      scrpos_63.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_64 = (a_64 * 17.0);
      highp float tmpvar_65;
      tmpvar_65 = (scrpos_63.y / 4.0);
      highp float tmpvar_66;
      tmpvar_66 = (fract(abs(tmpvar_65)) * 4.0);
      highp float tmpvar_67;
      if ((tmpvar_65 >= 0.0)) {
        tmpvar_67 = tmpvar_66;
      } else {
        tmpvar_67 = -(tmpvar_66);
      };
      highp float tmpvar_68;
      tmpvar_68 = (scrpos_63.x / 4.0);
      highp float tmpvar_69;
      tmpvar_69 = (fract(abs(tmpvar_68)) * 4.0);
      highp float tmpvar_70;
      if ((tmpvar_68 >= 0.0)) {
        tmpvar_70 = tmpvar_69;
      } else {
        tmpvar_70 = -(tmpvar_69);
      };
      highp float x_71;
      x_71 = ((a_64 - _DITHERMATRIX[
        int(tmpvar_67)
      ][
        int(tmpvar_70)
      ]) - 0.01);
      if ((x_71 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_31;
    tmpvar_31 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_31 >= _ModifySpecThreshold)) {
      mediump float attenuate_32;
      attenuate_32 = 1.0;
      if ((tmpvar_31 < _MaxSpecGradient)) {
        attenuate_32 = pow (((tmpvar_31 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_33;
      tmpvar_33 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_33.x)
       * attenuate_32)));
    };
  } else {
    mediump vec3 color_34;
    color_34 = _ModifySpecColor.xyz;
    mediump float tmpvar_35;
    tmpvar_35 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_35 >= _ModifySpecThreshold)) {
      if ((tmpvar_35 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_36;
        tmpvar_36.w = 0.0;
        tmpvar_36.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_37;
        tmpvar_37 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_34 = ((_ModifySpecCoff * mix (tmpvar_36, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_35 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_37.x).xyz;
      };
    } else {
      color_34 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_34);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_38;
  mediump vec3 R_39;
  mediump float intensity_40;
  mediump vec4 noiseTex_41;
  mediump vec4 spColor_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_42.xyz = tmpvar_43.xyz;
  spColor_42.w = outColor_5.w;
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_41 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (((1.99 * noiseTex_41.x) * _SPNoiseScaler) - 1.0);
  intensity_40 = tmpvar_45;
  highp vec3 tmpvar_46;
  highp vec3 I_47;
  I_47 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_41 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_46 = (I_47 - (2.0 * (
    dot (N_3, I_47)
   * N_3)));
  R_39 = tmpvar_46;
  lowp vec3 tmpvar_48;
  tmpvar_48 = textureCube (_SPCubeMap, R_39).xyz;
  reflection_38 = tmpvar_48;
  highp vec3 tmpvar_49;
  mediump vec3 x_50;
  x_50 = (spColor_42.xyz * _SPOldColor.xyz);
  tmpvar_49 = mix (x_50, ((reflection_38 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_42.xyz = tmpvar_49;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_40 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_40 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_51;
      tmpvar_51 = mix (spColor_42, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_40) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_42 = tmpvar_51;
    };
  };
  highp vec3 tmpvar_52;
  tmpvar_52 = mix (outColor_5.xyz, spColor_42.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_42.xyz = tmpvar_52;
  outColor_5.w = spColor_42.w;
  outColor_5.xyz = (spColor_42.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_53;
  color_53 = outColor_5.xyz;
  mediump vec3 tmpvar_54;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_54 = _lightProbColor.xyz;
  } else {
    tmpvar_54 = vec3(1.0, 1.0, 1.0);
  };
  color_53 = (outColor_5.xyz * tmpvar_54);
  mediump vec3 tmpvar_55;
  highp vec3 N_56;
  N_56 = N_3;
  highp vec3 V_57;
  V_57 = V_2;
  mediump float tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = pow (clamp ((1.001 - 
    dot (V_57, N_56)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_58 = (_RGBias + (tmpvar_59 * _RGScale));
  mediump vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_58 * _RGColor).xyz;
  mediump float tmpvar_61;
  tmpvar_61 = clamp (tmpvar_58, 0.0, 1.0);
  highp vec3 tmpvar_62;
  tmpvar_62 = mix (color_53, tmpvar_60, vec3((tmpvar_61 * _RGRatio)));
  tmpvar_55 = tmpvar_62;
  outColor_5.xyz = tmpvar_55;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_63;
    scrpos_63 = xlv_TEXCOORD3;
    mediump float a_64;
    a_64 = xlv_TEXCOORD3.z;
    if ((a_64 < 0.95)) {
      scrpos_63.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_64 = (a_64 * 17.0);
      highp float tmpvar_65;
      tmpvar_65 = (scrpos_63.y / 4.0);
      highp float tmpvar_66;
      tmpvar_66 = (fract(abs(tmpvar_65)) * 4.0);
      highp float tmpvar_67;
      if ((tmpvar_65 >= 0.0)) {
        tmpvar_67 = tmpvar_66;
      } else {
        tmpvar_67 = -(tmpvar_66);
      };
      highp float tmpvar_68;
      tmpvar_68 = (scrpos_63.x / 4.0);
      highp float tmpvar_69;
      tmpvar_69 = (fract(abs(tmpvar_68)) * 4.0);
      highp float tmpvar_70;
      if ((tmpvar_68 >= 0.0)) {
        tmpvar_70 = tmpvar_69;
      } else {
        tmpvar_70 = -(tmpvar_69);
      };
      highp float x_71;
      x_71 = ((a_64 - _DITHERMATRIX[
        int(tmpvar_67)
      ][
        int(tmpvar_70)
      ]) - 0.01);
      if ((x_71 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_81;
  mediump vec3 R_82;
  mediump float intensity_83;
  mediump vec4 noiseTex_84;
  mediump vec4 spColor_85;
  lowp vec4 tmpvar_86;
  tmpvar_86 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_85.xyz = tmpvar_86.xyz;
  spColor_85.w = outColor_5.w;
  lowp vec4 tmpvar_87;
  tmpvar_87 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_84 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (((1.99 * noiseTex_84.x) * _SPNoiseScaler) - 1.0);
  intensity_83 = tmpvar_88;
  highp vec3 tmpvar_89;
  highp vec3 I_90;
  I_90 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_84 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_89 = (I_90 - (2.0 * (
    dot (N_3, I_90)
   * N_3)));
  R_82 = tmpvar_89;
  lowp vec3 tmpvar_91;
  tmpvar_91 = textureCube (_SPCubeMap, R_82).xyz;
  reflection_81 = tmpvar_91;
  highp vec3 tmpvar_92;
  mediump vec3 x_93;
  x_93 = (spColor_85.xyz * _SPOldColor.xyz);
  tmpvar_92 = mix (x_93, ((reflection_81 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_85.xyz = tmpvar_92;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_83 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_83 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_94;
      tmpvar_94 = mix (spColor_85, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_83) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_85 = tmpvar_94;
    };
  };
  highp vec3 tmpvar_95;
  tmpvar_95 = mix (outColor_5.xyz, spColor_85.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_85.xyz = tmpvar_95;
  outColor_5.w = spColor_85.w;
  outColor_5.xyz = (spColor_85.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_96;
  color_96 = outColor_5.xyz;
  mediump vec3 tmpvar_97;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_97 = _lightProbColor.xyz;
  } else {
    tmpvar_97 = vec3(1.0, 1.0, 1.0);
  };
  color_96 = (outColor_5.xyz * tmpvar_97);
  mediump vec3 tmpvar_98;
  highp vec3 N_99;
  N_99 = N_3;
  highp vec3 V_100;
  V_100 = V_2;
  mediump float tmpvar_101;
  highp float tmpvar_102;
  tmpvar_102 = pow (clamp ((1.001 - 
    dot (V_100, N_99)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_101 = (_RGBias + (tmpvar_102 * _RGScale));
  mediump vec3 tmpvar_103;
  tmpvar_103 = (tmpvar_101 * _RGColor).xyz;
  mediump float tmpvar_104;
  tmpvar_104 = clamp (tmpvar_101, 0.0, 1.0);
  highp vec3 tmpvar_105;
  tmpvar_105 = mix (color_96, tmpvar_103, vec3((tmpvar_104 * _RGRatio)));
  tmpvar_98 = tmpvar_105;
  outColor_5.xyz = tmpvar_98;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_106;
    scrpos_106 = xlv_TEXCOORD3;
    mediump float a_107;
    a_107 = xlv_TEXCOORD3.z;
    if ((a_107 < 0.95)) {
      scrpos_106.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_107 = (a_107 * 17.0);
      highp float tmpvar_108;
      tmpvar_108 = (scrpos_106.y / 4.0);
      highp float tmpvar_109;
      tmpvar_109 = (fract(abs(tmpvar_108)) * 4.0);
      highp float tmpvar_110;
      if ((tmpvar_108 >= 0.0)) {
        tmpvar_110 = tmpvar_109;
      } else {
        tmpvar_110 = -(tmpvar_109);
      };
      highp float tmpvar_111;
      tmpvar_111 = (scrpos_106.x / 4.0);
      highp float tmpvar_112;
      tmpvar_112 = (fract(abs(tmpvar_111)) * 4.0);
      highp float tmpvar_113;
      if ((tmpvar_111 >= 0.0)) {
        tmpvar_113 = tmpvar_112;
      } else {
        tmpvar_113 = -(tmpvar_112);
      };
      highp float x_114;
      x_114 = ((a_107 - _DITHERMATRIX[
        int(tmpvar_110)
      ][
        int(tmpvar_113)
      ]) - 0.01);
      if ((x_114 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_81;
  mediump vec3 R_82;
  mediump float intensity_83;
  mediump vec4 noiseTex_84;
  mediump vec4 spColor_85;
  lowp vec4 tmpvar_86;
  tmpvar_86 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_85.xyz = tmpvar_86.xyz;
  spColor_85.w = outColor_5.w;
  lowp vec4 tmpvar_87;
  tmpvar_87 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_84 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (((1.99 * noiseTex_84.x) * _SPNoiseScaler) - 1.0);
  intensity_83 = tmpvar_88;
  highp vec3 tmpvar_89;
  highp vec3 I_90;
  I_90 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_84 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_89 = (I_90 - (2.0 * (
    dot (N_3, I_90)
   * N_3)));
  R_82 = tmpvar_89;
  lowp vec3 tmpvar_91;
  tmpvar_91 = textureCube (_SPCubeMap, R_82).xyz;
  reflection_81 = tmpvar_91;
  highp vec3 tmpvar_92;
  mediump vec3 x_93;
  x_93 = (spColor_85.xyz * _SPOldColor.xyz);
  tmpvar_92 = mix (x_93, ((reflection_81 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_85.xyz = tmpvar_92;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_83 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_83 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_94;
      tmpvar_94 = mix (spColor_85, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_83) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_85 = tmpvar_94;
    };
  };
  highp vec3 tmpvar_95;
  tmpvar_95 = mix (outColor_5.xyz, spColor_85.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_85.xyz = tmpvar_95;
  outColor_5.w = spColor_85.w;
  outColor_5.xyz = (spColor_85.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_96;
  color_96 = outColor_5.xyz;
  mediump vec3 tmpvar_97;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_97 = _lightProbColor.xyz;
  } else {
    tmpvar_97 = vec3(1.0, 1.0, 1.0);
  };
  color_96 = (outColor_5.xyz * tmpvar_97);
  mediump vec3 tmpvar_98;
  highp vec3 N_99;
  N_99 = N_3;
  highp vec3 V_100;
  V_100 = V_2;
  mediump float tmpvar_101;
  highp float tmpvar_102;
  tmpvar_102 = pow (clamp ((1.001 - 
    dot (V_100, N_99)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_101 = (_RGBias + (tmpvar_102 * _RGScale));
  mediump vec3 tmpvar_103;
  tmpvar_103 = (tmpvar_101 * _RGColor).xyz;
  mediump float tmpvar_104;
  tmpvar_104 = clamp (tmpvar_101, 0.0, 1.0);
  highp vec3 tmpvar_105;
  tmpvar_105 = mix (color_96, tmpvar_103, vec3((tmpvar_104 * _RGRatio)));
  tmpvar_98 = tmpvar_105;
  outColor_5.xyz = tmpvar_98;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_106;
    scrpos_106 = xlv_TEXCOORD3;
    mediump float a_107;
    a_107 = xlv_TEXCOORD3.z;
    if ((a_107 < 0.95)) {
      scrpos_106.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_107 = (a_107 * 17.0);
      highp float tmpvar_108;
      tmpvar_108 = (scrpos_106.y / 4.0);
      highp float tmpvar_109;
      tmpvar_109 = (fract(abs(tmpvar_108)) * 4.0);
      highp float tmpvar_110;
      if ((tmpvar_108 >= 0.0)) {
        tmpvar_110 = tmpvar_109;
      } else {
        tmpvar_110 = -(tmpvar_109);
      };
      highp float tmpvar_111;
      tmpvar_111 = (scrpos_106.x / 4.0);
      highp float tmpvar_112;
      tmpvar_112 = (fract(abs(tmpvar_111)) * 4.0);
      highp float tmpvar_113;
      if ((tmpvar_111 >= 0.0)) {
        tmpvar_113 = tmpvar_112;
      } else {
        tmpvar_113 = -(tmpvar_112);
      };
      highp float x_114;
      x_114 = ((a_107 - _DITHERMATRIX[
        int(tmpvar_110)
      ][
        int(tmpvar_113)
      ]) - 0.01);
      if ((x_114 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_3 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  mediump float tmpvar_10;
  mediump vec3 N_11;
  N_11 = tmpvar_9;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_12 = _CustomLightDir.xyz;
  };
  tmpvar_10 = ((dot (N_11, L_12) * 0.4975) + 0.5);
  highp vec4 spuvs_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (_glesVertex * 0.5);
  spuvs_13.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  spuvs_13.zw = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_16;
    highp vec4 tmpvar_17;
    tmpvar_17 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_18;
    tmpvar_18.x = tmpvar_17.x;
    tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
    o_16.xy = (tmpvar_18 + tmpvar_17.w);
    o_16.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_16.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = spuvs_13;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
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
uniform sampler2D _ModifySpecMask;
uniform mediump vec4 _ModifySpecColor;
uniform mediump float _ModifySpecThreshold;
uniform mediump float _MaxSpecGradient;
uniform mediump float _ModifySpecPower;
uniform mediump float _ModifySpecCoff;
uniform highp float _UsingDitherAlpha;
uniform mediump float _ModifySpec;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  if ((_ModifySpec == 0.0)) {
    mediump float tmpvar_74;
    tmpvar_74 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_74 >= _ModifySpecThreshold)) {
      mediump float attenuate_75;
      attenuate_75 = 1.0;
      if ((tmpvar_74 < _MaxSpecGradient)) {
        attenuate_75 = pow (((tmpvar_74 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower);
      };
      lowp vec4 tmpvar_76;
      tmpvar_76 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
      outColor_5.xyz = (outColor_5.xyz + ((_ModifySpecCoff * _ModifySpecColor.xyz) * (
        (_SpecMulti * tmpvar_76.x)
       * attenuate_75)));
    };
  } else {
    mediump vec3 color_77;
    color_77 = _ModifySpecColor.xyz;
    mediump float tmpvar_78;
    tmpvar_78 = max (dot (N_3, H_1), 0.0);
    if ((tmpvar_78 >= _ModifySpecThreshold)) {
      if ((tmpvar_78 < _MaxSpecGradient)) {
        mediump vec4 tmpvar_79;
        tmpvar_79.w = 0.0;
        tmpvar_79.xyz = _ModifySpecColor.xyz;
        lowp vec4 tmpvar_80;
        tmpvar_80 = texture2D (_ModifySpecMask, xlv_TEXCOORD0);
        color_77 = ((_ModifySpecCoff * mix (tmpvar_79, vec4(1.0, 1.0, 1.0, 1.0), vec4(
          (1.0 - pow (((tmpvar_78 - _ModifySpecThreshold) / (_MaxSpecGradient - _ModifySpecThreshold)), _ModifySpecPower))
        ))) * tmpvar_80.x).xyz;
      };
    } else {
      color_77 = vec3(1.0, 1.0, 1.0);
    };
    outColor_5.xyz = (outColor_5.xyz * color_77);
  };
  outColor_5.w = _BloomFactor;
  mediump vec3 reflection_81;
  mediump vec3 R_82;
  mediump float intensity_83;
  mediump vec4 noiseTex_84;
  mediump vec4 spColor_85;
  lowp vec4 tmpvar_86;
  tmpvar_86 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_85.xyz = tmpvar_86.xyz;
  spColor_85.w = outColor_5.w;
  lowp vec4 tmpvar_87;
  tmpvar_87 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_84 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (((1.99 * noiseTex_84.x) * _SPNoiseScaler) - 1.0);
  intensity_83 = tmpvar_88;
  highp vec3 tmpvar_89;
  highp vec3 I_90;
  I_90 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_84 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_89 = (I_90 - (2.0 * (
    dot (N_3, I_90)
   * N_3)));
  R_82 = tmpvar_89;
  lowp vec3 tmpvar_91;
  tmpvar_91 = textureCube (_SPCubeMap, R_82).xyz;
  reflection_81 = tmpvar_91;
  highp vec3 tmpvar_92;
  mediump vec3 x_93;
  x_93 = (spColor_85.xyz * _SPOldColor.xyz);
  tmpvar_92 = mix (x_93, ((reflection_81 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_85.xyz = tmpvar_92;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_83 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_83 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_94;
      tmpvar_94 = mix (spColor_85, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_83) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_85 = tmpvar_94;
    };
  };
  highp vec3 tmpvar_95;
  tmpvar_95 = mix (outColor_5.xyz, spColor_85.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_85.xyz = tmpvar_95;
  outColor_5.w = spColor_85.w;
  outColor_5.xyz = (spColor_85.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_96;
  color_96 = outColor_5.xyz;
  mediump vec3 tmpvar_97;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_97 = _lightProbColor.xyz;
  } else {
    tmpvar_97 = vec3(1.0, 1.0, 1.0);
  };
  color_96 = (outColor_5.xyz * tmpvar_97);
  mediump vec3 tmpvar_98;
  highp vec3 N_99;
  N_99 = N_3;
  highp vec3 V_100;
  V_100 = V_2;
  mediump float tmpvar_101;
  highp float tmpvar_102;
  tmpvar_102 = pow (clamp ((1.001 - 
    dot (V_100, N_99)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_101 = (_RGBias + (tmpvar_102 * _RGScale));
  mediump vec3 tmpvar_103;
  tmpvar_103 = (tmpvar_101 * _RGColor).xyz;
  mediump float tmpvar_104;
  tmpvar_104 = clamp (tmpvar_101, 0.0, 1.0);
  highp vec3 tmpvar_105;
  tmpvar_105 = mix (color_96, tmpvar_103, vec3((tmpvar_104 * _RGRatio)));
  tmpvar_98 = tmpvar_105;
  outColor_5.xyz = tmpvar_98;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_106;
    scrpos_106 = xlv_TEXCOORD3;
    mediump float a_107;
    a_107 = xlv_TEXCOORD3.z;
    if ((a_107 < 0.95)) {
      scrpos_106.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_107 = (a_107 * 17.0);
      highp float tmpvar_108;
      tmpvar_108 = (scrpos_106.y / 4.0);
      highp float tmpvar_109;
      tmpvar_109 = (fract(abs(tmpvar_108)) * 4.0);
      highp float tmpvar_110;
      if ((tmpvar_108 >= 0.0)) {
        tmpvar_110 = tmpvar_109;
      } else {
        tmpvar_110 = -(tmpvar_109);
      };
      highp float tmpvar_111;
      tmpvar_111 = (scrpos_106.x / 4.0);
      highp float tmpvar_112;
      tmpvar_112 = (fract(abs(tmpvar_111)) * 4.0);
      highp float tmpvar_113;
      if ((tmpvar_111 >= 0.0)) {
        tmpvar_113 = tmpvar_112;
      } else {
        tmpvar_113 = -(tmpvar_112);
      };
      highp float x_114;
      x_114 = ((a_107 - _DITHERMATRIX[
        int(tmpvar_110)
      ][
        int(tmpvar_113)
      ]) - 0.01);
      if ((x_114 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_5;
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
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
}
}
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry" "Reflected" = "Reflected" "RenderType" = "Opaque" }
  ZWrite Off
  Cull Front
  GpuProgramID 95966
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
Fallback "Diffuse"
CustomEditor "MoleMole.CharacterShaderEditorBase"
}