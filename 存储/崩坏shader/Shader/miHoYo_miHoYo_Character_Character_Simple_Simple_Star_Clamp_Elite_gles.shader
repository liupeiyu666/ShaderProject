//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Simple/Simple_Star_Clamp_Elite" {
Properties {
_Colortop ("Color Top", Color) = (0.02,0.04,0.09,1)
_Colorbottom ("Color Bottom", Color) = (0.27,0.16,0.37,1)
_BottomPos ("Gradient Offset", Range(-2, 2)) = 0
_BottonWidth ("Gradient Width", Range(0, 2)) = 1
_RimColor ("Rim Color", Color) = (0.42,0.46,1,1)
_RimPow ("Rim Width", Float) = 1
[Toggle] _RimTransparent ("Rim Range Change Transparent", Float) = 1
_RimPow2 ("Rim Transparent", Float) = 1
_Opaqueness ("Total Opaquness", Range(0, 1)) = 1
_RimSterngth ("Rim Strength", Float) = 1
_TwinkleTex ("Twinkle Tex (RGBA)", 2D) = "black" { }
_StarColor ("Star Color", Color) = (1,1,1,1)
_StarCenter ("Star Center", Vector) = (0,0,0,0)
_StarEmission ("Star Emission", Range(1, 100)) = 1
_SpeedX ("Speed X of Star Move", Range(-0.1, 0)) = -0.03
_SpeedY ("Speed Y of Star Move", Range(-0.1, 0)) = -0.03
_DispearDistance ("Dispear Distance", Range(0, 1)) = 0.7
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
[Toggle] _OutlineUseTangent ("Use Tangent For Outline", Float) = 0
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EliteColor1 ("Elite Color 1", Color) = (1,0.8,0,0.7)
_EliteEmissionScaler1 ("Elite Emission Scaler 1", Range(1, 10)) = 1
_EliteNormalDisplacement1 ("Elite Normal Displacment 1", Range(0, 0.1)) = 0.02
_EliteColor2 ("Elite Color 2", Color) = (1,0.85,0.27,0.27)
_EliteEmissionScaler2 ("Elite Emission Scaler 2", Range(1, 10)) = 1
_EliteNormalDisplacement2 ("Elite Normal Displacment 2", Range(0, 0.1)) = 0.04
_EliteColor3 ("Elite Color 3", Color) = (1,0.89,0.45,0.15)
_EliteEmissionScaler3 ("Elite Emission Scaler 3", Range(1, 10)) = 1
_EliteNormalDisplacement3 ("Elite Normal Displacment 3", Range(0, 0.1)) = 0
_EliteBloomFactor ("Elite Bloom Factor (only for layer 3)", Float) = 1
_SPCubeMap ("SP CubeMap", Cube) = "white" { }
_SPCubeMapColor ("SP CubeMap Color", Color) = (1,1,1,0)
_SPCubeMapOffset ("SP CubeMap Offset", Vector) = (0,0,0,0)
_SPCubeMapIntensity ("SP CubeMap Intensity", Range(0, 1)) = 0
_SPCubeMapNoiseIntensity ("SP CubeMap Noise Intensity", Range(0, 5)) = 0
_SPCubeMapBrightness ("SP CubeMap Brightness", Float) = 1.26
_SPOldColor ("SP Old Color", Color) = (1,1,1,0)
[Toggle] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
[Toggle] _SideRim ("SideRim", Float) = 0
_RimLightDir ("Rim Light Dir", Vector) = (1,1,1,1)
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 25522
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _StarCenter;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _StarCenter.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_13.xyz / tmpvar_13.w);
  tmpvar_14.w = (tmpvar_13.y / tmpvar_13.w);
  tmpvar_2 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_2 = (tmpvar_2 / tmpvar_2.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = o_5;
  xlv_TEXCOORD1 = o_10;
  xlv_NORMAL = normalize(normalize((_glesNormal * tmpvar_15)));
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform mediump float _StarEmission;
uniform highp vec4 _Colortop;
uniform highp vec4 _Colorbottom;
uniform highp vec4 _RimColor;
uniform highp float _RimPow;
uniform highp float _RimPow2;
uniform highp float _RimSterngth;
uniform highp float _BottomPos;
uniform highp float _BottonWidth;
uniform highp float _SpeedX;
uniform highp float _SpeedY;
uniform mediump vec4 _StarColor;
uniform sampler2D _TwinkleTex;
uniform highp vec4 _TwinkleTex_ST;
uniform highp float _DispearDistance;
uniform highp vec4 _RimLightDir;
uniform mediump float _Opaqueness;
uniform mediump float _RimTransparent;
uniform mediump float _SideRim;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 Star_1;
  mediump vec4 result_2;
  highp float rimalpha_3;
  highp float rimrgb_4;
  highp float rim_5;
  mediump vec3 V_6;
  mediump vec3 N_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_NORMAL);
  N_7 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  V_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - dot (N_7, V_6));
  rim_5 = tmpvar_10;
  rimrgb_4 = (pow (rim_5, _RimPow) * min (_RimSterngth, 1.0));
  if ((_SideRim > 0.0)) {
    mediump float rimLightDir_11;
    highp float tmpvar_12;
    tmpvar_12 = dot (N_7, normalize(_RimLightDir.xyz));
    rimLightDir_11 = tmpvar_12;
    if ((rimLightDir_11 < 0.0)) {
      rimrgb_4 = 0.0;
    };
  };
  rimalpha_3 = (pow (rim_5, _RimPow2) * min (_RimSterngth, 1.0));
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_Colorbottom, _Colortop, vec4(clamp ((
    (xlv_TEXCOORD2.w - (xlv_TEXCOORD3.y - _BottomPos))
   / _BottonWidth), 0.0, 1.0)));
  result_2 = tmpvar_13;
  if ((rimrgb_4 > 0.5)) {
    result_2 = _RimColor;
  };
  highp vec4 ScreenPosN_14;
  mediump vec4 ScreenPos_15;
  highp vec4 o_16;
  o_16.xzw = xlv_TEXCOORD1.xzw;
  o_16.y = (xlv_TEXCOORD1.w * 0.5);
  o_16.y = (((xlv_TEXCOORD1.y - o_16.y) * _ProjectionParams.x) + o_16.y);
  ScreenPos_15 = o_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (ScreenPos_15 / ScreenPos_15.w);
  ScreenPosN_14 = tmpvar_17;
  highp vec4 ScreenPosN_18;
  mediump vec4 ScreenPos_19;
  highp vec4 o_20;
  o_20.xzw = xlv_TEXCOORD0.xzw;
  o_20.y = (xlv_TEXCOORD0.w * 0.5);
  o_20.y = (((xlv_TEXCOORD0.y - o_20.y) * _ProjectionParams.x) + o_20.y);
  ScreenPos_19 = o_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (ScreenPos_19 / ScreenPos_19.w);
  ScreenPosN_18 = tmpvar_21;
  highp float tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = (_WorldSpaceCameraPos.xz - xlv_TEXCOORD3.xz);
  tmpvar_22 = sqrt(dot (tmpvar_23, tmpvar_23));
  highp float tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (ScreenPosN_18.xy - ScreenPosN_14.xy);
  tmpvar_24 = sqrt(dot (tmpvar_25, tmpvar_25));
  highp vec2 tmpvar_26;
  tmpvar_26.x = ((_Time.y * _SpeedX) + ((
    (ScreenPosN_18.xy - ScreenPosN_14.xy)
  .x * tmpvar_22) * 0.1));
  tmpvar_26.y = ((_Time.y * _SpeedY) + ((
    (ScreenPosN_18.xy - ScreenPosN_14.xy)
  .y * tmpvar_22) * 0.1));
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (tmpvar_26 * _TwinkleTex_ST.xy);
  tmpvar_27 = texture2D (_TwinkleTex, P_28);
  Star_1 = tmpvar_27;
  Star_1.w = (Star_1.w * _StarEmission);
  Star_1.xyz = (Star_1.xyz * _StarColor.xyz);
  highp float tmpvar_29;
  tmpvar_29 = clamp (((_DispearDistance - tmpvar_24) / -(tmpvar_24)), 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (result_2, Star_1, vec4(((tmpvar_29 * 
    (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
  ) * Star_1.w)));
  result_2.xyz = tmpvar_30.xyz;
  highp float tmpvar_31;
  tmpvar_31 = clamp (rimalpha_3, 0.0, 1.0);
  result_2.w = tmpvar_31;
  if ((_RimTransparent > 0.0)) {
    result_2.w = _Opaqueness;
  };
  gl_FragData[0] = result_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _StarCenter;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _StarCenter.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_13.xyz / tmpvar_13.w);
  tmpvar_14.w = (tmpvar_13.y / tmpvar_13.w);
  tmpvar_2 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_2 = (tmpvar_2 / tmpvar_2.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = o_5;
  xlv_TEXCOORD1 = o_10;
  xlv_NORMAL = normalize(normalize((_glesNormal * tmpvar_15)));
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform mediump float _StarEmission;
uniform highp vec4 _Colortop;
uniform highp vec4 _Colorbottom;
uniform highp vec4 _RimColor;
uniform highp float _RimPow;
uniform highp float _RimPow2;
uniform highp float _RimSterngth;
uniform highp float _BottomPos;
uniform highp float _BottonWidth;
uniform highp float _SpeedX;
uniform highp float _SpeedY;
uniform mediump vec4 _StarColor;
uniform sampler2D _TwinkleTex;
uniform highp vec4 _TwinkleTex_ST;
uniform highp float _DispearDistance;
uniform highp vec4 _RimLightDir;
uniform mediump float _Opaqueness;
uniform mediump float _RimTransparent;
uniform mediump float _SideRim;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 Star_1;
  mediump vec4 result_2;
  highp float rimalpha_3;
  highp float rimrgb_4;
  highp float rim_5;
  mediump vec3 V_6;
  mediump vec3 N_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_NORMAL);
  N_7 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  V_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - dot (N_7, V_6));
  rim_5 = tmpvar_10;
  rimrgb_4 = (pow (rim_5, _RimPow) * min (_RimSterngth, 1.0));
  if ((_SideRim > 0.0)) {
    mediump float rimLightDir_11;
    highp float tmpvar_12;
    tmpvar_12 = dot (N_7, normalize(_RimLightDir.xyz));
    rimLightDir_11 = tmpvar_12;
    if ((rimLightDir_11 < 0.0)) {
      rimrgb_4 = 0.0;
    };
  };
  rimalpha_3 = (pow (rim_5, _RimPow2) * min (_RimSterngth, 1.0));
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_Colorbottom, _Colortop, vec4(clamp ((
    (xlv_TEXCOORD2.w - (xlv_TEXCOORD3.y - _BottomPos))
   / _BottonWidth), 0.0, 1.0)));
  result_2 = tmpvar_13;
  if ((rimrgb_4 > 0.5)) {
    result_2 = _RimColor;
  };
  highp vec4 ScreenPosN_14;
  mediump vec4 ScreenPos_15;
  highp vec4 o_16;
  o_16.xzw = xlv_TEXCOORD1.xzw;
  o_16.y = (xlv_TEXCOORD1.w * 0.5);
  o_16.y = (((xlv_TEXCOORD1.y - o_16.y) * _ProjectionParams.x) + o_16.y);
  ScreenPos_15 = o_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (ScreenPos_15 / ScreenPos_15.w);
  ScreenPosN_14 = tmpvar_17;
  highp vec4 ScreenPosN_18;
  mediump vec4 ScreenPos_19;
  highp vec4 o_20;
  o_20.xzw = xlv_TEXCOORD0.xzw;
  o_20.y = (xlv_TEXCOORD0.w * 0.5);
  o_20.y = (((xlv_TEXCOORD0.y - o_20.y) * _ProjectionParams.x) + o_20.y);
  ScreenPos_19 = o_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (ScreenPos_19 / ScreenPos_19.w);
  ScreenPosN_18 = tmpvar_21;
  highp float tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = (_WorldSpaceCameraPos.xz - xlv_TEXCOORD3.xz);
  tmpvar_22 = sqrt(dot (tmpvar_23, tmpvar_23));
  highp float tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (ScreenPosN_18.xy - ScreenPosN_14.xy);
  tmpvar_24 = sqrt(dot (tmpvar_25, tmpvar_25));
  highp vec2 tmpvar_26;
  tmpvar_26.x = ((_Time.y * _SpeedX) + ((
    (ScreenPosN_18.xy - ScreenPosN_14.xy)
  .x * tmpvar_22) * 0.1));
  tmpvar_26.y = ((_Time.y * _SpeedY) + ((
    (ScreenPosN_18.xy - ScreenPosN_14.xy)
  .y * tmpvar_22) * 0.1));
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (tmpvar_26 * _TwinkleTex_ST.xy);
  tmpvar_27 = texture2D (_TwinkleTex, P_28);
  Star_1 = tmpvar_27;
  Star_1.w = (Star_1.w * _StarEmission);
  Star_1.xyz = (Star_1.xyz * _StarColor.xyz);
  highp float tmpvar_29;
  tmpvar_29 = clamp (((_DispearDistance - tmpvar_24) / -(tmpvar_24)), 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (result_2, Star_1, vec4(((tmpvar_29 * 
    (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
  ) * Star_1.w)));
  result_2.xyz = tmpvar_30.xyz;
  highp float tmpvar_31;
  tmpvar_31 = clamp (rimalpha_3, 0.0, 1.0);
  result_2.w = tmpvar_31;
  if ((_RimTransparent > 0.0)) {
    result_2.w = _Opaqueness;
  };
  gl_FragData[0] = result_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _StarCenter;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _StarCenter.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_13.xyz / tmpvar_13.w);
  tmpvar_14.w = (tmpvar_13.y / tmpvar_13.w);
  tmpvar_2 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_2 = (tmpvar_2 / tmpvar_2.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = o_5;
  xlv_TEXCOORD1 = o_10;
  xlv_NORMAL = normalize(normalize((_glesNormal * tmpvar_15)));
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform mediump float _StarEmission;
uniform highp vec4 _Colortop;
uniform highp vec4 _Colorbottom;
uniform highp vec4 _RimColor;
uniform highp float _RimPow;
uniform highp float _RimPow2;
uniform highp float _RimSterngth;
uniform highp float _BottomPos;
uniform highp float _BottonWidth;
uniform highp float _SpeedX;
uniform highp float _SpeedY;
uniform mediump vec4 _StarColor;
uniform sampler2D _TwinkleTex;
uniform highp vec4 _TwinkleTex_ST;
uniform highp float _DispearDistance;
uniform highp vec4 _RimLightDir;
uniform mediump float _Opaqueness;
uniform mediump float _RimTransparent;
uniform mediump float _SideRim;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 Star_1;
  mediump vec4 result_2;
  highp float rimalpha_3;
  highp float rimrgb_4;
  highp float rim_5;
  mediump vec3 V_6;
  mediump vec3 N_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_NORMAL);
  N_7 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  V_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - dot (N_7, V_6));
  rim_5 = tmpvar_10;
  rimrgb_4 = (pow (rim_5, _RimPow) * min (_RimSterngth, 1.0));
  if ((_SideRim > 0.0)) {
    mediump float rimLightDir_11;
    highp float tmpvar_12;
    tmpvar_12 = dot (N_7, normalize(_RimLightDir.xyz));
    rimLightDir_11 = tmpvar_12;
    if ((rimLightDir_11 < 0.0)) {
      rimrgb_4 = 0.0;
    };
  };
  rimalpha_3 = (pow (rim_5, _RimPow2) * min (_RimSterngth, 1.0));
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_Colorbottom, _Colortop, vec4(clamp ((
    (xlv_TEXCOORD2.w - (xlv_TEXCOORD3.y - _BottomPos))
   / _BottonWidth), 0.0, 1.0)));
  result_2 = tmpvar_13;
  if ((rimrgb_4 > 0.5)) {
    result_2 = _RimColor;
  };
  highp vec4 ScreenPosN_14;
  mediump vec4 ScreenPos_15;
  highp vec4 o_16;
  o_16.xzw = xlv_TEXCOORD1.xzw;
  o_16.y = (xlv_TEXCOORD1.w * 0.5);
  o_16.y = (((xlv_TEXCOORD1.y - o_16.y) * _ProjectionParams.x) + o_16.y);
  ScreenPos_15 = o_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (ScreenPos_15 / ScreenPos_15.w);
  ScreenPosN_14 = tmpvar_17;
  highp vec4 ScreenPosN_18;
  mediump vec4 ScreenPos_19;
  highp vec4 o_20;
  o_20.xzw = xlv_TEXCOORD0.xzw;
  o_20.y = (xlv_TEXCOORD0.w * 0.5);
  o_20.y = (((xlv_TEXCOORD0.y - o_20.y) * _ProjectionParams.x) + o_20.y);
  ScreenPos_19 = o_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (ScreenPos_19 / ScreenPos_19.w);
  ScreenPosN_18 = tmpvar_21;
  highp float tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = (_WorldSpaceCameraPos.xz - xlv_TEXCOORD3.xz);
  tmpvar_22 = sqrt(dot (tmpvar_23, tmpvar_23));
  highp float tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (ScreenPosN_18.xy - ScreenPosN_14.xy);
  tmpvar_24 = sqrt(dot (tmpvar_25, tmpvar_25));
  highp vec2 tmpvar_26;
  tmpvar_26.x = ((_Time.y * _SpeedX) + ((
    (ScreenPosN_18.xy - ScreenPosN_14.xy)
  .x * tmpvar_22) * 0.1));
  tmpvar_26.y = ((_Time.y * _SpeedY) + ((
    (ScreenPosN_18.xy - ScreenPosN_14.xy)
  .y * tmpvar_22) * 0.1));
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (tmpvar_26 * _TwinkleTex_ST.xy);
  tmpvar_27 = texture2D (_TwinkleTex, P_28);
  Star_1 = tmpvar_27;
  Star_1.w = (Star_1.w * _StarEmission);
  Star_1.xyz = (Star_1.xyz * _StarColor.xyz);
  highp float tmpvar_29;
  tmpvar_29 = clamp (((_DispearDistance - tmpvar_24) / -(tmpvar_24)), 0.0, 1.0);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (result_2, Star_1, vec4(((tmpvar_29 * 
    (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
  ) * Star_1.w)));
  result_2.xyz = tmpvar_30.xyz;
  highp float tmpvar_31;
  tmpvar_31 = clamp (rimalpha_3, 0.0, 1.0);
  result_2.w = tmpvar_31;
  if ((_RimTransparent > 0.0)) {
    result_2.w = _Opaqueness;
  };
  gl_FragData[0] = result_2;
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
  Name "OUTLINE"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 83854
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _Opaqueness;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2.xyz = xlv_COLOR0.xyz;
  outColor_2.w = _Opaqueness;
  highp vec4 scrpos_3;
  scrpos_3 = xlv_TEXCOORD0;
  mediump float a_4;
  a_4 = xlv_TEXCOORD0.z;
  if ((a_4 < 0.95)) {
    scrpos_3.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _Opaqueness;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2.xyz = xlv_COLOR0.xyz;
  outColor_2.w = _Opaqueness;
  highp vec4 scrpos_3;
  scrpos_3 = xlv_TEXCOORD0;
  mediump float a_4;
  a_4 = xlv_TEXCOORD0.z;
  if ((a_4 < 0.95)) {
    scrpos_3.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _Opaqueness;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2.xyz = xlv_COLOR0.xyz;
  outColor_2.w = _Opaqueness;
  highp vec4 scrpos_3;
  scrpos_3 = xlv_TEXCOORD0;
  mediump float a_4;
  a_4 = xlv_TEXCOORD0.z;
  if ((a_4 < 0.95)) {
    scrpos_3.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform mediump float _Opaqueness;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = outColor_2;
  };
  outColor_2.xyz = outColor_4.xyz;
  outColor_2.w = _Opaqueness;
  highp vec4 scrpos_7;
  scrpos_7 = xlv_TEXCOORD0;
  mediump float a_8;
  a_8 = xlv_TEXCOORD0.z;
  if ((a_8 < 0.95)) {
    scrpos_7.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform mediump float _Opaqueness;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = outColor_2;
  };
  outColor_2.xyz = outColor_4.xyz;
  outColor_2.w = _Opaqueness;
  highp vec4 scrpos_7;
  scrpos_7 = xlv_TEXCOORD0;
  mediump float a_8;
  a_8 = xlv_TEXCOORD0.z;
  if ((a_8 < 0.95)) {
    scrpos_7.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform mediump float _Opaqueness;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = outColor_2;
  };
  outColor_2.xyz = outColor_4.xyz;
  outColor_2.w = _Opaqueness;
  highp vec4 scrpos_7;
  scrpos_7 = xlv_TEXCOORD0;
  mediump float a_8;
  a_8 = xlv_TEXCOORD0.z;
  if ((a_8 < 0.95)) {
    scrpos_7.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
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
}