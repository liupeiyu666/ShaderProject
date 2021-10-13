//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar_Face" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
[Header(Texture)] _MainTex ("Main Tex (RGB)", 2D) = "white" { }
_LightMapTex ("Light Map Tex (RGB)", 2D) = "white" { }
_LightMapRowState ("Light Map Row state (RGB)", 2D) = "white" { }
_LightMapRowStateIDSForPixels ("Light Map Row state ids for pixels (RGB)", 2D) = "white" { }
[Toggle(USINGRGTOGETROWSTATE)] _UsingRGToGetRowState ("Using rg to get rowstate index, otherwise ba", Float) = 0
[Toggle(ISFLIPLIGHTMAPINHORIZON)] _IsFlipLightMapInHorizon ("Is Flip LightMap InHorizon", Float) = 0
_DegreeInY ("Degree In Y", Float) = 0
[Header(Light)] _LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
[Header(Shadow)] _LightArea ("Light Area Threshold", Range(0, 1)) = 0.5
_FirstShadowMultColor ("First Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
[Header(Specular)] _Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
[Header(Prepass Lighting)] _PrelightThreshold ("Prepass Lighting Threshold (Log)", Range(0, 10)) = 0.5
_PrelightScaler ("Prepass Lighting Scaler", Range(0, 10)) = 1
[Header(Outline)] _OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
[Header(Camera Fade)] _FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
[Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 1)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
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
  GpuProgramID 2940
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  outColor_7.xyz = outColor_7.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD6;
    mediump float a_44;
    a_44 = xlv_TEXCOORD6.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DegreeInY;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
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
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = floor((_DegreeInY + 0.499));
  tmpvar_4.x = 8.0;
  tmpvar_4.y = floor((tmpvar_17 / 32.0));
  tmpvar_4.z = floor(((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) / 8.0));
  tmpvar_4.w = (7.0 - ((tmpvar_17 - 
    (tmpvar_4.y * 32.0)
  ) - (tmpvar_4.z * 8.0)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_18.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = spuvs_14;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump float _BloomFactor;
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
uniform sampler2D _LightMapRowState;
uniform sampler2D _LightMapRowStateIDSForPixels;
uniform highp vec4 _LightMapRowState_TexelSize;
uniform highp float _UsingRGToGetRowState;
uniform highp float _IsFlipLightMapInHorizon;
uniform highp float _UsingDitherAlpha;
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
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump float lum_3;
  mediump vec3 lightmap_color_4;
  highp vec2 lightMapUV_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_6 = tmpvar_8;
  lightMapUV_5 = xlv_TEXCOORD0;
  if (bool(_IsFlipLightMapInHorizon)) {
    lightMapUV_5.x = (1.0 - xlv_TEXCOORD0.x);
  };
  highp ivec2 pixleID_9;
  highp vec2 curUV_10;
  mediump vec3 RGB_11;
  RGB_11 = vec3(0.0, 0.0, 0.0);
  if (bool(_UsingRGToGetRowState)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_12.xy;
  } else {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_LightMapRowStateIDSForPixels, lightMapUV_5);
    curUV_10 = tmpvar_13.zw;
  };
  highp ivec4 tmpvar_14;
  tmpvar_14 = ivec4((xlv_TEXCOORD4 + 0.499));
  highp ivec2 tmpvar_15;
  tmpvar_15 = ivec2(((curUV_10 * 255.0) + 0.499));
  pixleID_9.y = tmpvar_15.y;
  pixleID_9.x = ((tmpvar_15.x * tmpvar_14.x) + tmpvar_14.y);
  curUV_10 = ((vec2(pixleID_9) * _LightMapRowState_TexelSize.xy) + (0.499 * _LightMapRowState_TexelSize.xy));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMapRowState, curUV_10);
  highp float tmpvar_17;
  tmpvar_17 = (floor((
    float(int(((
      tmpvar_16[tmpvar_14.z]
     * 255.0) + 0.499)))
   / 
    exp2(float(tmpvar_14.w))
  )) / 2.0);
  highp float tmpvar_18;
  tmpvar_18 = (fract(abs(tmpvar_17)) * 2.0);
  highp float tmpvar_19;
  if ((tmpvar_17 >= 0.0)) {
    tmpvar_19 = tmpvar_18;
  } else {
    tmpvar_19 = -(tmpvar_18);
  };
  RGB_11.y = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  lightmap_color_4 = tmpvar_20;
  lum_3 = RGB_11.y;
  if ((lightmap_color_4.x > 0.5)) {
    mediump float threshold_21;
    mediump float lum_22;
    lum_22 = 1.0;
    threshold_21 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_21 < _LightArea)) {
      lum_22 = 0.0;
    } else {
      lum_22 = 1.0;
    };
    lum_3 = min (RGB_11.y, lum_22);
  } else {
    mediump float threshold_23;
    mediump float lum_24;
    lum_24 = 1.0;
    threshold_23 = ((xlv_COLOR1 + (
      (((xlv_COLOR0.x * lightmap_color_4.y) - 0.5) * 1.01)
     + 0.5)) * 0.5);
    if ((threshold_23 < _LightArea)) {
      lum_24 = 0.0;
    } else {
      lum_24 = 1.0;
    };
    lum_3 = lum_24;
  };
  mediump vec3 tmpvar_25;
  if ((lum_3 > 0.5)) {
    tmpvar_25 = baseTexColor_6;
  } else {
    tmpvar_25 = (_FirstShadowMultColor * baseTexColor_6);
  };
  outColor_7.xyz = tmpvar_25;
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD1);
  N_2 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_27;
  mediump vec3 reflection_28;
  mediump vec3 R_29;
  mediump float intensity_30;
  mediump vec4 noiseTex_31;
  mediump vec4 spColor_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_32.xyz = tmpvar_33.xyz;
  spColor_32.w = outColor_7.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (((1.99 * noiseTex_31.x) * _SPNoiseScaler) - 1.0);
  intensity_30 = tmpvar_35;
  highp vec3 tmpvar_36;
  highp vec3 I_37;
  I_37 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_31 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_36 = (I_37 - (2.0 * (
    dot (N_2, I_37)
   * N_2)));
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
  tmpvar_42 = mix (tmpvar_25, spColor_32.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_32.xyz = tmpvar_42;
  outColor_7.w = spColor_32.w;
  outColor_7.xyz = (spColor_32.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 tmpvar_43;
  highp vec3 N_44;
  N_44 = N_2;
  highp vec3 V_45;
  V_45 = V_1;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = pow (clamp ((1.001 - 
    dot (V_45, N_44)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_46 = (_RGBias + (tmpvar_47 * _RGScale));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46 * _RGColor).xyz;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (tmpvar_46, 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_7.xyz, tmpvar_48, vec3((tmpvar_49 * _RGRatio)));
  tmpvar_43 = tmpvar_50;
  outColor_7.xyz = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD6;
    mediump float a_52;
    a_52 = xlv_TEXCOORD6.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
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
  Cull Front
  GpuProgramID 90395
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