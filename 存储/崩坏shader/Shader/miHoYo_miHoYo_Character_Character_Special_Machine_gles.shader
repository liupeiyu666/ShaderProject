//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Special/Machine" {
Properties {
_Scale ("Scale Compared to Maya", Float) = 0.01
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_ZWrite ("Depth Write Switch (0: not write)", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 0.25
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Emission ("Emission Scaler", Range(1, 100)) = 0
[Toggle] _PartialEmission ("Partial Emission", Float) = 0
_PartialEmissionScaler ("Partial Emission Scaler", Range(1, 100)) = 1
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_ShadowMultColor ("Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
_ClipPlane ("Clip Plane (Model Space)", Vector) = (0,0,0,0)
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 1)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPOutlineColor ("SP Outline Color", Color) = (1,1,1,1)
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
[Toggle(OVERHEAT)] _Overheat ("Overheat", Float) = 0
_OverheatColor ("Overheat Color", Color) = (1,0,0,0)
_OverheatEmissionScaler ("Overheat Emission Scaler", Range(0, 100)) = 1
_OverheatIntensity ("Overheat Intensity", Range(0, 1)) = 0
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 59725
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_9.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  N_6 = tmpvar_13;
  mediump vec3 L_14;
  L_14 = _WorldSpaceLightPos0.xyz;
  tmpvar_9.x = ((dot (N_6, L_14) * 0.4975) + 0.5);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_15.w;
  objPos_5.xyz = (tmpvar_15.xyz / tmpvar_15.w);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_17;
  tmpvar_9.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_10 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_10.zw;
    tmpvar_8.xyw = o_18.xyw;
    tmpvar_8.z = _DitherAlpha;
  };
  highp vec4 vertex_21;
  vertex_21 = tmpvar_1;
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_23 < (_ClipPlane.w - 0.01))) {
    vertex_21.xyz = (_glesVertex.xyz - ((tmpvar_23 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  alpha_2 = tmpvar_22;
  tmpvar_9.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (vertex_21 * 0.5);
  spuvs_24.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_26;
  tmpvar_26.x = (tmpvar_25.x + (tmpvar_25.z * tmpvar_25.z));
  tmpvar_26.y = ((tmpvar_25.y + (0.5 * tmpvar_25.z)) + ((0.5 * tmpvar_25.x) * tmpvar_25.x));
  spuvs_24.zw = ((tmpvar_26 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = spuvs_24;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float intensity_6;
  mediump vec4 spColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_10;
  tmpvar_10 = (((1.99 * tmpvar_9.x) * _SPNoiseScaler) - 1.0);
  intensity_6 = tmpvar_10;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_6 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_6 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_11;
      tmpvar_11 = mix (spColor_7.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_6) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_7.xyz = tmpvar_11;
    };
  };
  spColor_7.xyz = (spColor_7.xyz * _Color.xyz);
  highp vec4 tmpvar_12;
  tmpvar_12 = mix (outColor_4, spColor_7, vec4(xlat_mutable_SPIntensity));
  spColor_7 = tmpvar_12;
  outColor_4.xyz = (spColor_7.xyz * _Emission);
  outColor_4.w = (spColor_7.w * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_13;
    scrpos_13 = xlv_TEXCOORD7;
    mediump float a_14;
    a_14 = xlv_TEXCOORD7.z;
    if ((a_14 < 0.95)) {
      scrpos_13.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_14 = (a_14 * 17.0);
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_13.y / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float tmpvar_18;
      tmpvar_18 = (scrpos_13.x / 4.0);
      highp float tmpvar_19;
      tmpvar_19 = (fract(abs(tmpvar_18)) * 4.0);
      highp float tmpvar_20;
      if ((tmpvar_18 >= 0.0)) {
        tmpvar_20 = tmpvar_19;
      } else {
        tmpvar_20 = -(tmpvar_19);
      };
      highp float x_21;
      x_21 = ((a_14 - _DITHERMATRIX[
        int(tmpvar_17)
      ][
        int(tmpvar_20)
      ]) - 0.01);
      if ((x_21 < 0.0)) {
        discard;
      };
    };
  };
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_9.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  N_6 = tmpvar_13;
  mediump vec3 L_14;
  L_14 = _WorldSpaceLightPos0.xyz;
  tmpvar_9.x = ((dot (N_6, L_14) * 0.4975) + 0.5);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_15.w;
  objPos_5.xyz = (tmpvar_15.xyz / tmpvar_15.w);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_17;
  tmpvar_9.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_10 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_10.zw;
    tmpvar_8.xyw = o_18.xyw;
    tmpvar_8.z = _DitherAlpha;
  };
  highp vec4 vertex_21;
  vertex_21 = tmpvar_1;
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_23 < (_ClipPlane.w - 0.01))) {
    vertex_21.xyz = (_glesVertex.xyz - ((tmpvar_23 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  alpha_2 = tmpvar_22;
  tmpvar_9.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (vertex_21 * 0.5);
  spuvs_24.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_26;
  tmpvar_26.x = (tmpvar_25.x + (tmpvar_25.z * tmpvar_25.z));
  tmpvar_26.y = ((tmpvar_25.y + (0.5 * tmpvar_25.z)) + ((0.5 * tmpvar_25.x) * tmpvar_25.x));
  spuvs_24.zw = ((tmpvar_26 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = spuvs_24;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float intensity_6;
  mediump vec4 spColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_10;
  tmpvar_10 = (((1.99 * tmpvar_9.x) * _SPNoiseScaler) - 1.0);
  intensity_6 = tmpvar_10;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_6 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_6 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_11;
      tmpvar_11 = mix (spColor_7.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_6) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_7.xyz = tmpvar_11;
    };
  };
  spColor_7.xyz = (spColor_7.xyz * _Color.xyz);
  highp vec4 tmpvar_12;
  tmpvar_12 = mix (outColor_4, spColor_7, vec4(xlat_mutable_SPIntensity));
  spColor_7 = tmpvar_12;
  outColor_4.xyz = (spColor_7.xyz * _Emission);
  outColor_4.w = (spColor_7.w * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_13;
    scrpos_13 = xlv_TEXCOORD7;
    mediump float a_14;
    a_14 = xlv_TEXCOORD7.z;
    if ((a_14 < 0.95)) {
      scrpos_13.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_14 = (a_14 * 17.0);
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_13.y / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float tmpvar_18;
      tmpvar_18 = (scrpos_13.x / 4.0);
      highp float tmpvar_19;
      tmpvar_19 = (fract(abs(tmpvar_18)) * 4.0);
      highp float tmpvar_20;
      if ((tmpvar_18 >= 0.0)) {
        tmpvar_20 = tmpvar_19;
      } else {
        tmpvar_20 = -(tmpvar_19);
      };
      highp float x_21;
      x_21 = ((a_14 - _DITHERMATRIX[
        int(tmpvar_17)
      ][
        int(tmpvar_20)
      ]) - 0.01);
      if ((x_21 < 0.0)) {
        discard;
      };
    };
  };
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_9.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  N_6 = tmpvar_13;
  mediump vec3 L_14;
  L_14 = _WorldSpaceLightPos0.xyz;
  tmpvar_9.x = ((dot (N_6, L_14) * 0.4975) + 0.5);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_15.w;
  objPos_5.xyz = (tmpvar_15.xyz / tmpvar_15.w);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_17;
  tmpvar_9.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_10 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_10.zw;
    tmpvar_8.xyw = o_18.xyw;
    tmpvar_8.z = _DitherAlpha;
  };
  highp vec4 vertex_21;
  vertex_21 = tmpvar_1;
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_23 < (_ClipPlane.w - 0.01))) {
    vertex_21.xyz = (_glesVertex.xyz - ((tmpvar_23 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  alpha_2 = tmpvar_22;
  tmpvar_9.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (vertex_21 * 0.5);
  spuvs_24.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_26;
  tmpvar_26.x = (tmpvar_25.x + (tmpvar_25.z * tmpvar_25.z));
  tmpvar_26.y = ((tmpvar_25.y + (0.5 * tmpvar_25.z)) + ((0.5 * tmpvar_25.x) * tmpvar_25.x));
  spuvs_24.zw = ((tmpvar_26 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = spuvs_24;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float intensity_6;
  mediump vec4 spColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_10;
  tmpvar_10 = (((1.99 * tmpvar_9.x) * _SPNoiseScaler) - 1.0);
  intensity_6 = tmpvar_10;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_6 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_6 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_11;
      tmpvar_11 = mix (spColor_7.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_6) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_7.xyz = tmpvar_11;
    };
  };
  spColor_7.xyz = (spColor_7.xyz * _Color.xyz);
  highp vec4 tmpvar_12;
  tmpvar_12 = mix (outColor_4, spColor_7, vec4(xlat_mutable_SPIntensity));
  spColor_7 = tmpvar_12;
  outColor_4.xyz = (spColor_7.xyz * _Emission);
  outColor_4.w = (spColor_7.w * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_13;
    scrpos_13 = xlv_TEXCOORD7;
    mediump float a_14;
    a_14 = xlv_TEXCOORD7.z;
    if ((a_14 < 0.95)) {
      scrpos_13.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_14 = (a_14 * 17.0);
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_13.y / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float tmpvar_18;
      tmpvar_18 = (scrpos_13.x / 4.0);
      highp float tmpvar_19;
      tmpvar_19 = (fract(abs(tmpvar_18)) * 4.0);
      highp float tmpvar_20;
      if ((tmpvar_18 >= 0.0)) {
        tmpvar_20 = tmpvar_19;
      } else {
        tmpvar_20 = -(tmpvar_19);
      };
      highp float x_21;
      x_21 = ((a_14 - _DITHERMATRIX[
        int(tmpvar_17)
      ][
        int(tmpvar_20)
      ]) - 0.01);
      if ((x_21 < 0.0)) {
        discard;
      };
    };
  };
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "OVERHEAT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec3 _OverheatColor;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _OverheatIntensity;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  N_6 = tmpvar_14;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  tmpvar_10.x = ((dot (N_6, L_15) * 0.4975) + 0.5);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_16.w;
  objPos_5.xyz = (tmpvar_16.xyz / tmpvar_16.w);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_18;
  tmpvar_10.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  tmpvar_8.xyz = (_OverheatColor * _OverheatEmissionScaler);
  tmpvar_8.w = (_glesColor.x * _OverheatIntensity);
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_19;
    highp vec4 tmpvar_20;
    tmpvar_20 = (tmpvar_11 * 0.5);
    highp vec2 tmpvar_21;
    tmpvar_21.x = tmpvar_20.x;
    tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
    o_19.xy = (tmpvar_21 + tmpvar_20.w);
    o_19.zw = tmpvar_11.zw;
    tmpvar_9.xyw = o_19.xyw;
    tmpvar_9.z = _DitherAlpha;
  };
  highp vec4 vertex_22;
  vertex_22 = tmpvar_1;
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_24 < (_ClipPlane.w - 0.01))) {
    vertex_22.xyz = (_glesVertex.xyz - ((tmpvar_24 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_2 = tmpvar_23;
  tmpvar_10.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (vertex_22 * 0.5);
  spuvs_25.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_27;
  tmpvar_27.x = (tmpvar_26.x + (tmpvar_26.z * tmpvar_26.z));
  tmpvar_27.y = ((tmpvar_26.y + (0.5 * tmpvar_26.z)) + ((0.5 * tmpvar_26.x) * tmpvar_26.x));
  spuvs_25.zw = ((tmpvar_27 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = spuvs_25;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float tmpvar_6;
  tmpvar_6 = mix (1.0, _OverheatEmissionScaler, xlv_TEXCOORD3.w);
  mediump float spFlag_7;
  mediump float intensity_8;
  mediump vec4 spColor_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_12;
  tmpvar_12 = (((1.99 * tmpvar_11.x) * _SPNoiseScaler) - 1.0);
  intensity_8 = tmpvar_12;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  spFlag_7 = 1.0;
  if ((intensity_8 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
    spFlag_7 = 0.0;
  } else {
    if ((intensity_8 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_13;
      tmpvar_13 = mix (spColor_9.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_8) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_9.xyz = tmpvar_13;
    } else {
      spColor_9.xyz = (spColor_9.xyz * tmpvar_6);
    };
  };
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (outColor_4, spColor_9, vec4(xlat_mutable_SPIntensity));
  spColor_9 = tmpvar_14;
  outColor_4.w = spColor_9.w;
  outColor_4.xyz = (spColor_9.xyz * _Emission);
  outColor_4.xyz = mix (mix (outColor_4.xyz, xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.www), outColor_4.xyz, vec3(spFlag_7));
  outColor_4.w = (spColor_9.w * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD7;
    mediump float a_16;
    a_16 = xlv_TEXCOORD7.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
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
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "OVERHEAT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec3 _OverheatColor;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _OverheatIntensity;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  N_6 = tmpvar_14;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  tmpvar_10.x = ((dot (N_6, L_15) * 0.4975) + 0.5);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_16.w;
  objPos_5.xyz = (tmpvar_16.xyz / tmpvar_16.w);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_18;
  tmpvar_10.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  tmpvar_8.xyz = (_OverheatColor * _OverheatEmissionScaler);
  tmpvar_8.w = (_glesColor.x * _OverheatIntensity);
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_19;
    highp vec4 tmpvar_20;
    tmpvar_20 = (tmpvar_11 * 0.5);
    highp vec2 tmpvar_21;
    tmpvar_21.x = tmpvar_20.x;
    tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
    o_19.xy = (tmpvar_21 + tmpvar_20.w);
    o_19.zw = tmpvar_11.zw;
    tmpvar_9.xyw = o_19.xyw;
    tmpvar_9.z = _DitherAlpha;
  };
  highp vec4 vertex_22;
  vertex_22 = tmpvar_1;
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_24 < (_ClipPlane.w - 0.01))) {
    vertex_22.xyz = (_glesVertex.xyz - ((tmpvar_24 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_2 = tmpvar_23;
  tmpvar_10.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (vertex_22 * 0.5);
  spuvs_25.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_27;
  tmpvar_27.x = (tmpvar_26.x + (tmpvar_26.z * tmpvar_26.z));
  tmpvar_27.y = ((tmpvar_26.y + (0.5 * tmpvar_26.z)) + ((0.5 * tmpvar_26.x) * tmpvar_26.x));
  spuvs_25.zw = ((tmpvar_27 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = spuvs_25;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float tmpvar_6;
  tmpvar_6 = mix (1.0, _OverheatEmissionScaler, xlv_TEXCOORD3.w);
  mediump float spFlag_7;
  mediump float intensity_8;
  mediump vec4 spColor_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_12;
  tmpvar_12 = (((1.99 * tmpvar_11.x) * _SPNoiseScaler) - 1.0);
  intensity_8 = tmpvar_12;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  spFlag_7 = 1.0;
  if ((intensity_8 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
    spFlag_7 = 0.0;
  } else {
    if ((intensity_8 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_13;
      tmpvar_13 = mix (spColor_9.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_8) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_9.xyz = tmpvar_13;
    } else {
      spColor_9.xyz = (spColor_9.xyz * tmpvar_6);
    };
  };
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (outColor_4, spColor_9, vec4(xlat_mutable_SPIntensity));
  spColor_9 = tmpvar_14;
  outColor_4.w = spColor_9.w;
  outColor_4.xyz = (spColor_9.xyz * _Emission);
  outColor_4.xyz = mix (mix (outColor_4.xyz, xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.www), outColor_4.xyz, vec3(spFlag_7));
  outColor_4.w = (spColor_9.w * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD7;
    mediump float a_16;
    a_16 = xlv_TEXCOORD7.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
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
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "OVERHEAT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec3 _OverheatColor;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _OverheatIntensity;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  N_6 = tmpvar_14;
  mediump vec3 L_15;
  L_15 = _WorldSpaceLightPos0.xyz;
  tmpvar_10.x = ((dot (N_6, L_15) * 0.4975) + 0.5);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_16.w;
  objPos_5.xyz = (tmpvar_16.xyz / tmpvar_16.w);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_18;
  tmpvar_10.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  tmpvar_8.xyz = (_OverheatColor * _OverheatEmissionScaler);
  tmpvar_8.w = (_glesColor.x * _OverheatIntensity);
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_19;
    highp vec4 tmpvar_20;
    tmpvar_20 = (tmpvar_11 * 0.5);
    highp vec2 tmpvar_21;
    tmpvar_21.x = tmpvar_20.x;
    tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
    o_19.xy = (tmpvar_21 + tmpvar_20.w);
    o_19.zw = tmpvar_11.zw;
    tmpvar_9.xyw = o_19.xyw;
    tmpvar_9.z = _DitherAlpha;
  };
  highp vec4 vertex_22;
  vertex_22 = tmpvar_1;
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_24 < (_ClipPlane.w - 0.01))) {
    vertex_22.xyz = (_glesVertex.xyz - ((tmpvar_24 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_2 = tmpvar_23;
  tmpvar_10.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (vertex_22 * 0.5);
  spuvs_25.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_27;
  tmpvar_27.x = (tmpvar_26.x + (tmpvar_26.z * tmpvar_26.z));
  tmpvar_27.y = ((tmpvar_26.y + (0.5 * tmpvar_26.z)) + ((0.5 * tmpvar_26.x) * tmpvar_26.x));
  spuvs_25.zw = ((tmpvar_27 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = spuvs_25;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float tmpvar_6;
  tmpvar_6 = mix (1.0, _OverheatEmissionScaler, xlv_TEXCOORD3.w);
  mediump float spFlag_7;
  mediump float intensity_8;
  mediump vec4 spColor_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_12;
  tmpvar_12 = (((1.99 * tmpvar_11.x) * _SPNoiseScaler) - 1.0);
  intensity_8 = tmpvar_12;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  spFlag_7 = 1.0;
  if ((intensity_8 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
    spFlag_7 = 0.0;
  } else {
    if ((intensity_8 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_13;
      tmpvar_13 = mix (spColor_9.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_8) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_9.xyz = tmpvar_13;
    } else {
      spColor_9.xyz = (spColor_9.xyz * tmpvar_6);
    };
  };
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (outColor_4, spColor_9, vec4(xlat_mutable_SPIntensity));
  spColor_9 = tmpvar_14;
  outColor_4.w = spColor_9.w;
  outColor_4.xyz = (spColor_9.xyz * _Emission);
  outColor_4.xyz = mix (mix (outColor_4.xyz, xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.www), outColor_4.xyz, vec3(spFlag_7));
  outColor_4.w = (spColor_9.w * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD7;
    mediump float a_16;
    a_16 = xlv_TEXCOORD7.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
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
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_11.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  N_6 = tmpvar_15;
  mediump vec3 L_16;
  L_16 = _WorldSpaceLightPos0.xyz;
  tmpvar_11.x = ((dot (N_6, L_16) * 0.4975) + 0.5);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_17.w;
  objPos_5.xyz = (tmpvar_17.xyz / tmpvar_17.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_19;
  tmpvar_11.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_12.zw;
    tmpvar_10.xyw = o_20.xyw;
    tmpvar_10.z = _DitherAlpha;
  };
  highp vec4 vertex_23;
  vertex_23 = tmpvar_1;
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_25 < (_ClipPlane.w - 0.01))) {
    vertex_23.xyz = (_glesVertex.xyz - ((tmpvar_25 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_24 = 0.0;
  } else {
    tmpvar_24 = 1.0;
  };
  alpha_2 = tmpvar_24;
  tmpvar_11.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (vertex_23 * 0.5);
  spuvs_26.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spuvs_26.zw = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = N_6;
  tmpvar_9 = V_4;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = spuvs_26;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float intensity_6;
  mediump vec4 spColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_10;
  tmpvar_10 = (((1.99 * tmpvar_9.x) * _SPNoiseScaler) - 1.0);
  intensity_6 = tmpvar_10;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_6 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_6 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_11;
      tmpvar_11 = mix (spColor_7.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_6) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_7.xyz = tmpvar_11;
    };
  };
  spColor_7.xyz = (spColor_7.xyz * _Color.xyz);
  highp vec4 tmpvar_12;
  tmpvar_12 = mix (outColor_4, spColor_7, vec4(xlat_mutable_SPIntensity));
  spColor_7 = tmpvar_12;
  outColor_4.xyz = (spColor_7.xyz * _Emission);
  outColor_4.w = (spColor_7.w * xlv_COLOR1.y);
  mediump vec3 tmpvar_13;
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD6), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_14 = (_RGBias + (tmpvar_15 * _RGScale));
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * _RGColor).xyz;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (tmpvar_14, 0.0, 1.0);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (outColor_4.xyz, tmpvar_16, vec3((tmpvar_17 * _RGRatio)));
  tmpvar_13 = tmpvar_18;
  outColor_4.xyz = tmpvar_13;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_19;
    scrpos_19 = xlv_TEXCOORD7;
    mediump float a_20;
    a_20 = xlv_TEXCOORD7.z;
    if ((a_20 < 0.95)) {
      scrpos_19.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_20 = (a_20 * 17.0);
      highp float tmpvar_21;
      tmpvar_21 = (scrpos_19.y / 4.0);
      highp float tmpvar_22;
      tmpvar_22 = (fract(abs(tmpvar_21)) * 4.0);
      highp float tmpvar_23;
      if ((tmpvar_21 >= 0.0)) {
        tmpvar_23 = tmpvar_22;
      } else {
        tmpvar_23 = -(tmpvar_22);
      };
      highp float tmpvar_24;
      tmpvar_24 = (scrpos_19.x / 4.0);
      highp float tmpvar_25;
      tmpvar_25 = (fract(abs(tmpvar_24)) * 4.0);
      highp float tmpvar_26;
      if ((tmpvar_24 >= 0.0)) {
        tmpvar_26 = tmpvar_25;
      } else {
        tmpvar_26 = -(tmpvar_25);
      };
      highp float x_27;
      x_27 = ((a_20 - _DITHERMATRIX[
        int(tmpvar_23)
      ][
        int(tmpvar_26)
      ]) - 0.01);
      if ((x_27 < 0.0)) {
        discard;
      };
    };
  };
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_11.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  N_6 = tmpvar_15;
  mediump vec3 L_16;
  L_16 = _WorldSpaceLightPos0.xyz;
  tmpvar_11.x = ((dot (N_6, L_16) * 0.4975) + 0.5);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_17.w;
  objPos_5.xyz = (tmpvar_17.xyz / tmpvar_17.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_19;
  tmpvar_11.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_12.zw;
    tmpvar_10.xyw = o_20.xyw;
    tmpvar_10.z = _DitherAlpha;
  };
  highp vec4 vertex_23;
  vertex_23 = tmpvar_1;
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_25 < (_ClipPlane.w - 0.01))) {
    vertex_23.xyz = (_glesVertex.xyz - ((tmpvar_25 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_24 = 0.0;
  } else {
    tmpvar_24 = 1.0;
  };
  alpha_2 = tmpvar_24;
  tmpvar_11.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (vertex_23 * 0.5);
  spuvs_26.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spuvs_26.zw = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = N_6;
  tmpvar_9 = V_4;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = spuvs_26;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float intensity_6;
  mediump vec4 spColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_10;
  tmpvar_10 = (((1.99 * tmpvar_9.x) * _SPNoiseScaler) - 1.0);
  intensity_6 = tmpvar_10;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_6 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_6 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_11;
      tmpvar_11 = mix (spColor_7.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_6) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_7.xyz = tmpvar_11;
    };
  };
  spColor_7.xyz = (spColor_7.xyz * _Color.xyz);
  highp vec4 tmpvar_12;
  tmpvar_12 = mix (outColor_4, spColor_7, vec4(xlat_mutable_SPIntensity));
  spColor_7 = tmpvar_12;
  outColor_4.xyz = (spColor_7.xyz * _Emission);
  outColor_4.w = (spColor_7.w * xlv_COLOR1.y);
  mediump vec3 tmpvar_13;
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD6), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_14 = (_RGBias + (tmpvar_15 * _RGScale));
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * _RGColor).xyz;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (tmpvar_14, 0.0, 1.0);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (outColor_4.xyz, tmpvar_16, vec3((tmpvar_17 * _RGRatio)));
  tmpvar_13 = tmpvar_18;
  outColor_4.xyz = tmpvar_13;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_19;
    scrpos_19 = xlv_TEXCOORD7;
    mediump float a_20;
    a_20 = xlv_TEXCOORD7.z;
    if ((a_20 < 0.95)) {
      scrpos_19.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_20 = (a_20 * 17.0);
      highp float tmpvar_21;
      tmpvar_21 = (scrpos_19.y / 4.0);
      highp float tmpvar_22;
      tmpvar_22 = (fract(abs(tmpvar_21)) * 4.0);
      highp float tmpvar_23;
      if ((tmpvar_21 >= 0.0)) {
        tmpvar_23 = tmpvar_22;
      } else {
        tmpvar_23 = -(tmpvar_22);
      };
      highp float tmpvar_24;
      tmpvar_24 = (scrpos_19.x / 4.0);
      highp float tmpvar_25;
      tmpvar_25 = (fract(abs(tmpvar_24)) * 4.0);
      highp float tmpvar_26;
      if ((tmpvar_24 >= 0.0)) {
        tmpvar_26 = tmpvar_25;
      } else {
        tmpvar_26 = -(tmpvar_25);
      };
      highp float x_27;
      x_27 = ((a_20 - _DITHERMATRIX[
        int(tmpvar_23)
      ][
        int(tmpvar_26)
      ]) - 0.01);
      if ((x_27 < 0.0)) {
        discard;
      };
    };
  };
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_11.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  N_6 = tmpvar_15;
  mediump vec3 L_16;
  L_16 = _WorldSpaceLightPos0.xyz;
  tmpvar_11.x = ((dot (N_6, L_16) * 0.4975) + 0.5);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_17.w;
  objPos_5.xyz = (tmpvar_17.xyz / tmpvar_17.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_19;
  tmpvar_11.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_12.zw;
    tmpvar_10.xyw = o_20.xyw;
    tmpvar_10.z = _DitherAlpha;
  };
  highp vec4 vertex_23;
  vertex_23 = tmpvar_1;
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_25 < (_ClipPlane.w - 0.01))) {
    vertex_23.xyz = (_glesVertex.xyz - ((tmpvar_25 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_24 = 0.0;
  } else {
    tmpvar_24 = 1.0;
  };
  alpha_2 = tmpvar_24;
  tmpvar_11.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (vertex_23 * 0.5);
  spuvs_26.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spuvs_26.zw = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = N_6;
  tmpvar_9 = V_4;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = spuvs_26;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float intensity_6;
  mediump vec4 spColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_10;
  tmpvar_10 = (((1.99 * tmpvar_9.x) * _SPNoiseScaler) - 1.0);
  intensity_6 = tmpvar_10;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_6 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_6 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_11;
      tmpvar_11 = mix (spColor_7.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_6) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_7.xyz = tmpvar_11;
    };
  };
  spColor_7.xyz = (spColor_7.xyz * _Color.xyz);
  highp vec4 tmpvar_12;
  tmpvar_12 = mix (outColor_4, spColor_7, vec4(xlat_mutable_SPIntensity));
  spColor_7 = tmpvar_12;
  outColor_4.xyz = (spColor_7.xyz * _Emission);
  outColor_4.w = (spColor_7.w * xlv_COLOR1.y);
  mediump vec3 tmpvar_13;
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD6), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_14 = (_RGBias + (tmpvar_15 * _RGScale));
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * _RGColor).xyz;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (tmpvar_14, 0.0, 1.0);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (outColor_4.xyz, tmpvar_16, vec3((tmpvar_17 * _RGRatio)));
  tmpvar_13 = tmpvar_18;
  outColor_4.xyz = tmpvar_13;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_19;
    scrpos_19 = xlv_TEXCOORD7;
    mediump float a_20;
    a_20 = xlv_TEXCOORD7.z;
    if ((a_20 < 0.95)) {
      scrpos_19.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_20 = (a_20 * 17.0);
      highp float tmpvar_21;
      tmpvar_21 = (scrpos_19.y / 4.0);
      highp float tmpvar_22;
      tmpvar_22 = (fract(abs(tmpvar_21)) * 4.0);
      highp float tmpvar_23;
      if ((tmpvar_21 >= 0.0)) {
        tmpvar_23 = tmpvar_22;
      } else {
        tmpvar_23 = -(tmpvar_22);
      };
      highp float tmpvar_24;
      tmpvar_24 = (scrpos_19.x / 4.0);
      highp float tmpvar_25;
      tmpvar_25 = (fract(abs(tmpvar_24)) * 4.0);
      highp float tmpvar_26;
      if ((tmpvar_24 >= 0.0)) {
        tmpvar_26 = tmpvar_25;
      } else {
        tmpvar_26 = -(tmpvar_25);
      };
      highp float x_27;
      x_27 = ((a_20 - _DITHERMATRIX[
        int(tmpvar_23)
      ][
        int(tmpvar_26)
      ]) - 0.01);
      if ((x_27 < 0.0)) {
        discard;
      };
    };
  };
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "OVERHEAT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec3 _OverheatColor;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _OverheatIntensity;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  tmpvar_11 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_12.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_1.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(normalize((_glesNormal * tmpvar_15)));
  N_6 = tmpvar_16;
  mediump vec3 L_17;
  L_17 = _WorldSpaceLightPos0.xyz;
  tmpvar_12.x = ((dot (N_6, L_17) * 0.4975) + 0.5);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_18.w;
  objPos_5.xyz = (tmpvar_18.xyz / tmpvar_18.w);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_20;
  tmpvar_12.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  tmpvar_8.xyz = (_OverheatColor * _OverheatEmissionScaler);
  tmpvar_8.w = (_glesColor.x * _OverheatIntensity);
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_13 * 0.5);
    highp vec2 tmpvar_23;
    tmpvar_23.x = tmpvar_22.x;
    tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
    o_21.xy = (tmpvar_23 + tmpvar_22.w);
    o_21.zw = tmpvar_13.zw;
    tmpvar_11.xyw = o_21.xyw;
    tmpvar_11.z = _DitherAlpha;
  };
  highp vec4 vertex_24;
  vertex_24 = tmpvar_1;
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_26 < (_ClipPlane.w - 0.01))) {
    vertex_24.xyz = (_glesVertex.xyz - ((tmpvar_26 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  alpha_2 = tmpvar_25;
  tmpvar_12.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (vertex_24 * 0.5);
  spuvs_27.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_29;
  tmpvar_29.x = (tmpvar_28.x + (tmpvar_28.z * tmpvar_28.z));
  tmpvar_29.y = ((tmpvar_28.y + (0.5 * tmpvar_28.z)) + ((0.5 * tmpvar_28.x) * tmpvar_28.x));
  spuvs_27.zw = ((tmpvar_29 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_9 = N_6;
  tmpvar_10 = V_4;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = spuvs_27;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float tmpvar_6;
  tmpvar_6 = mix (1.0, _OverheatEmissionScaler, xlv_TEXCOORD3.w);
  mediump float spFlag_7;
  mediump float intensity_8;
  mediump vec4 spColor_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_12;
  tmpvar_12 = (((1.99 * tmpvar_11.x) * _SPNoiseScaler) - 1.0);
  intensity_8 = tmpvar_12;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  spFlag_7 = 1.0;
  if ((intensity_8 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
    spFlag_7 = 0.0;
  } else {
    if ((intensity_8 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_13;
      tmpvar_13 = mix (spColor_9.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_8) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_9.xyz = tmpvar_13;
    } else {
      spColor_9.xyz = (spColor_9.xyz * tmpvar_6);
    };
  };
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (outColor_4, spColor_9, vec4(xlat_mutable_SPIntensity));
  spColor_9 = tmpvar_14;
  outColor_4.w = spColor_9.w;
  outColor_4.xyz = (spColor_9.xyz * _Emission);
  outColor_4.xyz = mix (mix (outColor_4.xyz, xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.www), outColor_4.xyz, vec3(spFlag_7));
  outColor_4.w = (spColor_9.w * xlv_COLOR1.y);
  mediump vec3 tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD6), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_16 = (_RGBias + (tmpvar_17 * _RGScale));
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _RGColor).xyz;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (tmpvar_16, 0.0, 1.0);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (outColor_4.xyz, tmpvar_18, vec3((tmpvar_19 * _RGRatio)));
  tmpvar_15 = tmpvar_20;
  outColor_4.xyz = tmpvar_15;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_21;
    scrpos_21 = xlv_TEXCOORD7;
    mediump float a_22;
    a_22 = xlv_TEXCOORD7.z;
    if ((a_22 < 0.95)) {
      scrpos_21.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_22 = (a_22 * 17.0);
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_21.y / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float tmpvar_26;
      tmpvar_26 = (scrpos_21.x / 4.0);
      highp float tmpvar_27;
      tmpvar_27 = (fract(abs(tmpvar_26)) * 4.0);
      highp float tmpvar_28;
      if ((tmpvar_26 >= 0.0)) {
        tmpvar_28 = tmpvar_27;
      } else {
        tmpvar_28 = -(tmpvar_27);
      };
      highp float x_29;
      x_29 = ((a_22 - _DITHERMATRIX[
        int(tmpvar_25)
      ][
        int(tmpvar_28)
      ]) - 0.01);
      if ((x_29 < 0.0)) {
        discard;
      };
    };
  };
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "OVERHEAT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec3 _OverheatColor;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _OverheatIntensity;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  tmpvar_11 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_12.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_1.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(normalize((_glesNormal * tmpvar_15)));
  N_6 = tmpvar_16;
  mediump vec3 L_17;
  L_17 = _WorldSpaceLightPos0.xyz;
  tmpvar_12.x = ((dot (N_6, L_17) * 0.4975) + 0.5);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_18.w;
  objPos_5.xyz = (tmpvar_18.xyz / tmpvar_18.w);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_20;
  tmpvar_12.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  tmpvar_8.xyz = (_OverheatColor * _OverheatEmissionScaler);
  tmpvar_8.w = (_glesColor.x * _OverheatIntensity);
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_13 * 0.5);
    highp vec2 tmpvar_23;
    tmpvar_23.x = tmpvar_22.x;
    tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
    o_21.xy = (tmpvar_23 + tmpvar_22.w);
    o_21.zw = tmpvar_13.zw;
    tmpvar_11.xyw = o_21.xyw;
    tmpvar_11.z = _DitherAlpha;
  };
  highp vec4 vertex_24;
  vertex_24 = tmpvar_1;
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_26 < (_ClipPlane.w - 0.01))) {
    vertex_24.xyz = (_glesVertex.xyz - ((tmpvar_26 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  alpha_2 = tmpvar_25;
  tmpvar_12.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (vertex_24 * 0.5);
  spuvs_27.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_29;
  tmpvar_29.x = (tmpvar_28.x + (tmpvar_28.z * tmpvar_28.z));
  tmpvar_29.y = ((tmpvar_28.y + (0.5 * tmpvar_28.z)) + ((0.5 * tmpvar_28.x) * tmpvar_28.x));
  spuvs_27.zw = ((tmpvar_29 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_9 = N_6;
  tmpvar_10 = V_4;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = spuvs_27;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float tmpvar_6;
  tmpvar_6 = mix (1.0, _OverheatEmissionScaler, xlv_TEXCOORD3.w);
  mediump float spFlag_7;
  mediump float intensity_8;
  mediump vec4 spColor_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_12;
  tmpvar_12 = (((1.99 * tmpvar_11.x) * _SPNoiseScaler) - 1.0);
  intensity_8 = tmpvar_12;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  spFlag_7 = 1.0;
  if ((intensity_8 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
    spFlag_7 = 0.0;
  } else {
    if ((intensity_8 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_13;
      tmpvar_13 = mix (spColor_9.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_8) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_9.xyz = tmpvar_13;
    } else {
      spColor_9.xyz = (spColor_9.xyz * tmpvar_6);
    };
  };
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (outColor_4, spColor_9, vec4(xlat_mutable_SPIntensity));
  spColor_9 = tmpvar_14;
  outColor_4.w = spColor_9.w;
  outColor_4.xyz = (spColor_9.xyz * _Emission);
  outColor_4.xyz = mix (mix (outColor_4.xyz, xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.www), outColor_4.xyz, vec3(spFlag_7));
  outColor_4.w = (spColor_9.w * xlv_COLOR1.y);
  mediump vec3 tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD6), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_16 = (_RGBias + (tmpvar_17 * _RGScale));
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _RGColor).xyz;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (tmpvar_16, 0.0, 1.0);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (outColor_4.xyz, tmpvar_18, vec3((tmpvar_19 * _RGRatio)));
  tmpvar_15 = tmpvar_20;
  outColor_4.xyz = tmpvar_15;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_21;
    scrpos_21 = xlv_TEXCOORD7;
    mediump float a_22;
    a_22 = xlv_TEXCOORD7.z;
    if ((a_22 < 0.95)) {
      scrpos_21.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_22 = (a_22 * 17.0);
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_21.y / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float tmpvar_26;
      tmpvar_26 = (scrpos_21.x / 4.0);
      highp float tmpvar_27;
      tmpvar_27 = (fract(abs(tmpvar_26)) * 4.0);
      highp float tmpvar_28;
      if ((tmpvar_26 >= 0.0)) {
        tmpvar_28 = tmpvar_27;
      } else {
        tmpvar_28 = -(tmpvar_27);
      };
      highp float x_29;
      x_29 = ((a_22 - _DITHERMATRIX[
        int(tmpvar_25)
      ][
        int(tmpvar_28)
      ]) - 0.01);
      if ((x_29 < 0.0)) {
        discard;
      };
    };
  };
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "OVERHEAT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec3 _OverheatColor;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _OverheatIntensity;
uniform mediump float _Opaqueness;
uniform mediump float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec3 H_3;
  mediump vec3 V_4;
  highp vec4 objPos_5;
  mediump vec3 N_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  tmpvar_11 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_12.yw = vec2(0.0, 0.0);
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_1.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(normalize((_glesNormal * tmpvar_15)));
  N_6 = tmpvar_16;
  mediump vec3 L_17;
  L_17 = _WorldSpaceLightPos0.xyz;
  tmpvar_12.x = ((dot (N_6, L_17) * 0.4975) + 0.5);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  objPos_5.w = tmpvar_18.w;
  objPos_5.xyz = (tmpvar_18.xyz / tmpvar_18.w);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - objPos_5.xyz));
  V_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz + V_4));
  H_3 = tmpvar_20;
  tmpvar_12.z = max (0.0, pow (max (
    dot (N_6, H_3)
  , 0.001), _Shininess));
  tmpvar_8.xyz = (_OverheatColor * _OverheatEmissionScaler);
  tmpvar_8.w = (_glesColor.x * _OverheatIntensity);
  alpha_2 = 1.0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_13 * 0.5);
    highp vec2 tmpvar_23;
    tmpvar_23.x = tmpvar_22.x;
    tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
    o_21.xy = (tmpvar_23 + tmpvar_22.w);
    o_21.zw = tmpvar_13.zw;
    tmpvar_11.xyw = o_21.xyw;
    tmpvar_11.z = _DitherAlpha;
  };
  highp vec4 vertex_24;
  vertex_24 = tmpvar_1;
  highp float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_26 < (_ClipPlane.w - 0.01))) {
    vertex_24.xyz = (_glesVertex.xyz - ((tmpvar_26 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  alpha_2 = tmpvar_25;
  tmpvar_12.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (vertex_24 * 0.5);
  spuvs_27.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_29;
  tmpvar_29.x = (tmpvar_28.x + (tmpvar_28.z * tmpvar_28.z));
  tmpvar_29.y = ((tmpvar_28.y + (0.5 * tmpvar_28.z)) + ((0.5 * tmpvar_28.x) * tmpvar_28.x));
  spuvs_27.zw = ((tmpvar_29 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_9 = N_6;
  tmpvar_10 = V_4;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD2 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = spuvs_27;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump float _PartialEmission;
uniform mediump float _PartialEmissionScaler;
uniform mediump float _OverheatEmissionScaler;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec4 baseTexColor_1;
  mediump vec3 specColor_2;
  mediump vec3 diffColor_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  diffColor_3 = vec3(1.0, 1.0, 1.0);
  specColor_2 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  baseTexColor_1 = tmpvar_5;
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_3 = (baseTexColor_1.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_3 = baseTexColor_1.xyz;
  };
  specColor_2 = ((_LightSpecColor * _SpecMulti) * xlv_COLOR1.z);
  outColor_4.xyz = (((diffColor_3 * _Color.xyz) * _EnvColor.xyz) + specColor_2);
  outColor_4.w = 1.0;
  outColor_4.xyz = mix (outColor_4.xyz, (baseTexColor_1.xyz * _PartialEmissionScaler), vec3((baseTexColor_1.w * _PartialEmission)));
  mediump float tmpvar_6;
  tmpvar_6 = mix (1.0, _OverheatEmissionScaler, xlv_TEXCOORD3.w);
  mediump float spFlag_7;
  mediump float intensity_8;
  mediump vec4 spColor_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_12;
  tmpvar_12 = (((1.99 * tmpvar_11.x) * _SPNoiseScaler) - 1.0);
  intensity_8 = tmpvar_12;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  spFlag_7 = 1.0;
  if ((intensity_8 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
    spFlag_7 = 0.0;
  } else {
    if ((intensity_8 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_13;
      tmpvar_13 = mix (spColor_9.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_8) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_9.xyz = tmpvar_13;
    } else {
      spColor_9.xyz = (spColor_9.xyz * tmpvar_6);
    };
  };
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (outColor_4, spColor_9, vec4(xlat_mutable_SPIntensity));
  spColor_9 = tmpvar_14;
  outColor_4.w = spColor_9.w;
  outColor_4.xyz = (spColor_9.xyz * _Emission);
  outColor_4.xyz = mix (mix (outColor_4.xyz, xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.www), outColor_4.xyz, vec3(spFlag_7));
  outColor_4.w = (spColor_9.w * xlv_COLOR1.y);
  mediump vec3 tmpvar_15;
  mediump float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD6), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_16 = (_RGBias + (tmpvar_17 * _RGScale));
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _RGColor).xyz;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (tmpvar_16, 0.0, 1.0);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (outColor_4.xyz, tmpvar_18, vec3((tmpvar_19 * _RGRatio)));
  tmpvar_15 = tmpvar_20;
  outColor_4.xyz = tmpvar_15;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_21;
    scrpos_21 = xlv_TEXCOORD7;
    mediump float a_22;
    a_22 = xlv_TEXCOORD7.z;
    if ((a_22 < 0.95)) {
      scrpos_21.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
      a_22 = (a_22 * 17.0);
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_21.y / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float tmpvar_26;
      tmpvar_26 = (scrpos_21.x / 4.0);
      highp float tmpvar_27;
      tmpvar_27 = (fract(abs(tmpvar_26)) * 4.0);
      highp float tmpvar_28;
      if ((tmpvar_26 >= 0.0)) {
        tmpvar_28 = tmpvar_27;
      } else {
        tmpvar_28 = -(tmpvar_27);
      };
      highp float x_29;
      x_29 = ((a_22 - _DITHERMATRIX[
        int(tmpvar_25)
      ][
        int(tmpvar_28)
      ]) - 0.01);
      if ((x_29 < 0.0)) {
        discard;
      };
    };
  };
  outColor_4.w = clamp (outColor_4.w, 0.0, 1.0);
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
Keywords { "OVERHEAT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "OVERHEAT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "OVERHEAT" }
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
Keywords { "RIM_GLOW" "OVERHEAT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "OVERHEAT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "OVERHEAT" }
""
}
}
}
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 82327
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
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = (unity_MatrixMV * _glesVertex);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  tmpvar_5 = _OutlineColor;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_7;
    fadeOffset_7 = _FadeOffset;
    highp float fadeDistance_8;
    fadeDistance_8 = _FadeDistance;
    highp float tmpvar_9;
    tmpvar_9 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
    tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  };
  tmpvar_5.w = (tmpvar_5.w * _Opaqueness);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixMV[0].xyz;
  tmpvar_15[1] = unity_MatrixMV[1].xyz;
  tmpvar_15[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_16.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(N_2);
  N_2 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_18));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_17.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (vertex_11 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_21.x + (tmpvar_21.z * tmpvar_21.z));
  tmpvar_22.y = ((tmpvar_21.y + (0.5 * tmpvar_21.z)) + ((0.5 * tmpvar_21.x) * tmpvar_21.x));
  spnoiseuv_20 = ((tmpvar_22 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_25;
    tmpvar_25.x = tmpvar_24.x;
    tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
    o_23.xy = (tmpvar_25 + tmpvar_24.w);
    o_23.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_23.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_20;
  xlv_TEXCOORD3 = tmpvar_6;
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
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
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
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = (unity_MatrixMV * _glesVertex);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  tmpvar_5 = _OutlineColor;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_7;
    fadeOffset_7 = _FadeOffset;
    highp float fadeDistance_8;
    fadeDistance_8 = _FadeDistance;
    highp float tmpvar_9;
    tmpvar_9 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
    tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  };
  tmpvar_5.w = (tmpvar_5.w * _Opaqueness);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixMV[0].xyz;
  tmpvar_15[1] = unity_MatrixMV[1].xyz;
  tmpvar_15[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_16.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(N_2);
  N_2 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_18));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_17.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (vertex_11 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_21.x + (tmpvar_21.z * tmpvar_21.z));
  tmpvar_22.y = ((tmpvar_21.y + (0.5 * tmpvar_21.z)) + ((0.5 * tmpvar_21.x) * tmpvar_21.x));
  spnoiseuv_20 = ((tmpvar_22 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_25;
    tmpvar_25.x = tmpvar_24.x;
    tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
    o_23.xy = (tmpvar_25 + tmpvar_24.w);
    o_23.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_23.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_20;
  xlv_TEXCOORD3 = tmpvar_6;
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
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
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
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = (unity_MatrixMV * _glesVertex);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  tmpvar_5 = _OutlineColor;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_7;
    fadeOffset_7 = _FadeOffset;
    highp float fadeDistance_8;
    fadeDistance_8 = _FadeDistance;
    highp float tmpvar_9;
    tmpvar_9 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
    tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  };
  tmpvar_5.w = (tmpvar_5.w * _Opaqueness);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixMV[0].xyz;
  tmpvar_15[1] = unity_MatrixMV[1].xyz;
  tmpvar_15[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_16.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(N_2);
  N_2 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_18));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_17.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (vertex_11 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_21.x + (tmpvar_21.z * tmpvar_21.z));
  tmpvar_22.y = ((tmpvar_21.y + (0.5 * tmpvar_21.z)) + ((0.5 * tmpvar_21.x) * tmpvar_21.x));
  spnoiseuv_20 = ((tmpvar_22 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_25;
    tmpvar_25.x = tmpvar_24.x;
    tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
    o_23.xy = (tmpvar_25 + tmpvar_24.w);
    o_23.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_23.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_20;
  xlv_TEXCOORD3 = tmpvar_6;
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
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
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
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 149407
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = (vertex_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (tmpvar_7.x + (tmpvar_7.z * tmpvar_7.z));
  tmpvar_8.y = ((tmpvar_7.y + (0.5 * tmpvar_7.z)) + ((0.5 * tmpvar_7.x) * tmpvar_7.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_8 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump float emissionFactor_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy).w;
  emissionFactor_1 = tmpvar_3;
  color_2.w = (mix (_BloomFactor, _EmissionBloomFactor, emissionFactor_1) * xlv_TEXCOORD0.z);
  mediump float intensity_4;
  mediump float outBloomFactor_5;
  outBloomFactor_5 = color_2.w;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_7;
  tmpvar_7 = (((1.99 * tmpvar_6.x) * _SPNoiseScaler) - 1.0);
  intensity_4 = tmpvar_7;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_4 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_4 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_8;
    tmpvar_8 = mix (color_2.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_4) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_5 = tmpvar_8;
  } else {
    if ((intensity_4 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_5 = (outBloomFactor_5 * _SPOpaqueness);
    };
  };
  color_2.w = outBloomFactor_5;
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = (vertex_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (tmpvar_7.x + (tmpvar_7.z * tmpvar_7.z));
  tmpvar_8.y = ((tmpvar_7.y + (0.5 * tmpvar_7.z)) + ((0.5 * tmpvar_7.x) * tmpvar_7.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_8 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump float emissionFactor_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy).w;
  emissionFactor_1 = tmpvar_3;
  color_2.w = (mix (_BloomFactor, _EmissionBloomFactor, emissionFactor_1) * xlv_TEXCOORD0.z);
  mediump float intensity_4;
  mediump float outBloomFactor_5;
  outBloomFactor_5 = color_2.w;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_7;
  tmpvar_7 = (((1.99 * tmpvar_6.x) * _SPNoiseScaler) - 1.0);
  intensity_4 = tmpvar_7;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_4 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_4 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_8;
    tmpvar_8 = mix (color_2.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_4) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_5 = tmpvar_8;
  } else {
    if ((intensity_4 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_5 = (outBloomFactor_5 * _SPOpaqueness);
    };
  };
  color_2.w = outBloomFactor_5;
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = (vertex_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (tmpvar_7.x + (tmpvar_7.z * tmpvar_7.z));
  tmpvar_8.y = ((tmpvar_7.y + (0.5 * tmpvar_7.z)) + ((0.5 * tmpvar_7.x) * tmpvar_7.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_8 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump float emissionFactor_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy).w;
  emissionFactor_1 = tmpvar_3;
  color_2.w = (mix (_BloomFactor, _EmissionBloomFactor, emissionFactor_1) * xlv_TEXCOORD0.z);
  mediump float intensity_4;
  mediump float outBloomFactor_5;
  outBloomFactor_5 = color_2.w;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_7;
  tmpvar_7 = (((1.99 * tmpvar_6.x) * _SPNoiseScaler) - 1.0);
  intensity_4 = tmpvar_7;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_4 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_4 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_8;
    tmpvar_8 = mix (color_2.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_4) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_5 = tmpvar_8;
  } else {
    if ((intensity_4 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_5 = (outBloomFactor_5 * _SPOpaqueness);
    };
  };
  color_2.w = outBloomFactor_5;
  gl_FragData[0] = color_2;
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
CustomEditor "MoleMole.CharacterMachineShaderEditor"
}