//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Air_Water_Level" {
Properties {
_MianColor ("MianColor", Color) = (1,0,0,0)
_Opacity ("Opacity", Range(0, 1)) = 1
_DeepColor ("Deep Color", Color) = (0,0,0,0)
_ShalowColor ("Shalow Color", Color) = (1,1,1,0)
_WaterDepth ("Water Depth", Float) = 0
_WaterFalloff ("Water Falloff", Range(-1, 0)) = 0
_Distortion ("Distortion", Float) = 0.5
_DistortionOffset ("DistortionOffset", Vector) = (0,0,0,0)
_WaterNormal ("Water Normal", 2D) = "bump" { }
_WaterNormalSpeed ("WaterNormalSpeed", Vector) = (-0.03,0,0.04,0.04)
_NormalScale ("Normal Scale", Float) = 0
_WaterNormalMask ("Water NormalMask", 2D) = "white" { }
_NormalMaskScale ("NormalMaskScale", Float) = 1
_OffsetTex ("OffsetTex", 2D) = "white" { }
_OffsetSpeed ("OffsetSpeed", Vector) = (0,0,0,0)
_OffsetIntensity ("OffsetIntensity", Vector) = (0,0,0,0)
_DepthColor ("DepthColor", Color) = (0,0,0,0)
_DepthDistance ("DepthDistance", Float) = 0
_FogValue ("FogIntensity", Float) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 1711
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform sampler2D _OffsetTex;
uniform highp vec4 _OffsetTex_ST;
uniform highp vec2 _OffsetSpeed;
uniform highp vec3 _OffsetIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
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
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * _OffsetSpeed) + ((_glesMultiTexCoord0.xy * _OffsetTex_ST.xy) + _OffsetTex_ST.zw));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_OffsetTex, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = _OffsetIntensity;
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesColor * tmpvar_13) * (tmpvar_15 * tmpvar_16)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_2.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_4 = _glesColor;
  tmpvar_5 = _glesMultiTexCoord0;
  tmpvar_6 = _glesMultiTexCoord1;
  tmpvar_7 = _glesMultiTexCoord2;
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = o_10;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp float _Opacity;
uniform highp vec4 _DepthColor;
uniform highp vec4 _MianColor;
uniform highp vec4 _DeepColor;
uniform highp vec4 _ShalowColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _WaterDepth;
uniform highp float _WaterFalloff;
uniform highp float _NormalScale;
uniform sampler2D _WaterNormal;
uniform highp vec4 _WaterNormalSpeed;
uniform sampler2D _WaterNormalMask;
uniform highp float _NormalMaskScale;
uniform highp vec4 _WaterNormal_ST;
uniform highp float _Distortion;
uniform highp vec4 _DistortionOffset;
uniform highp float _DepthDistance;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _CustomDepthTexture;
uniform highp float _FogValue;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec3 addFog_3;
  highp vec4 ase_screenPosNorm_4;
  highp vec4 screenColor65_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3);
  highp float z_7;
  z_7 = tmpvar_6.x;
  highp float tmpvar_8;
  tmpvar_8 = clamp (pow ((
    abs(((1.0/((
      (_ZBufferParams.z * z_7)
     + _ZBufferParams.w))) - xlv_TEXCOORD3.w))
   + 
    (_WaterDepth * 100.0)
  ), _WaterFalloff), 0.0, 1.0);
  highp vec4 o_9;
  o_9.xzw = xlv_TEXCOORD3.xzw;
  o_9.y = (xlv_TEXCOORD3.w * 0.5);
  o_9.y = (((xlv_TEXCOORD3.y - o_9.y) * _ProjectionParams.x) + o_9.y);
  highp float tmpvar_10;
  tmpvar_10 = (_NormalScale * 0.01);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _WaterNormal_ST.xy) + _WaterNormal_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_WaterNormalMask, xlv_TEXCOORD0.xy);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_Time.y * _WaterNormalSpeed.xy) + tmpvar_11);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((_Time.y * _WaterNormalSpeed.zw) + tmpvar_11);
  highp vec3 tmpvar_15;
  tmpvar_15.z = 0.0;
  tmpvar_15.xy = (o_9 / xlv_TEXCOORD3.w).xy;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_WaterNormal, tmpvar_13);
  mediump vec4 packednormal_17;
  packednormal_17 = tmpvar_16;
  mediump float bumpScale_18;
  bumpScale_18 = tmpvar_10;
  mediump vec3 normal_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((packednormal_17.xyz * 2.0) - 1.0);
  normal_19.z = tmpvar_20.z;
  normal_19.xy = (tmpvar_20.xy * bumpScale_18);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_WaterNormal, tmpvar_14);
  mediump vec4 packednormal_22;
  packednormal_22 = tmpvar_21;
  mediump float bumpScale_23;
  bumpScale_23 = tmpvar_10;
  mediump vec3 normal_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((packednormal_22.xyz * 2.0) - 1.0);
  normal_24.z = tmpvar_25.z;
  normal_24.xy = (tmpvar_25.xy * bumpScale_23);
  mediump vec3 tmpvar_26;
  tmpvar_26.xy = (normal_19.xy + normal_24.xy);
  tmpvar_26.z = (tmpvar_20.z * tmpvar_25.z);
  mediump vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_26);
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((tmpvar_15 + (
    (tmpvar_27 * _Distortion)
   * 
    (tmpvar_12 * _NormalMaskScale)
  .x)).xy + (_DistortionOffset.xy * 0.1));
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  screenColor65_5 = tmpvar_28;
  highp vec4 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm_4.xyw = tmpvar_30.xyw;
  ase_screenPosNorm_4.z = ((tmpvar_30.z * 0.5) + 0.5);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_32;
  z_32 = tmpvar_31.x;
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (_DepthColor, (_MianColor + mix (
    mix (_DeepColor, _ShalowColor, vec4(tmpvar_8))
  , screenColor65_5, vec4(tmpvar_8))), vec4(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_32)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_4.z)
     + _ZBufferParams.w)))) / _DepthDistance)
  ), 0.0, 1.0)));
  mediump vec3 srcColor_34;
  srcColor_34 = tmpvar_33.xyz;
  mediump vec3 tmpvar_35;
  tmpvar_35 = mix (srcColor_34, xlv_COLOR1.xyz, xlv_COLOR1.www);
  addFog_3 = tmpvar_35;
  aseOutAlpha_2 = _Opacity;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33.xyz, addFog_3, vec3(_FogValue));
  aseOutColor_1 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = aseOutColor_1;
  tmpvar_38.w = tmpvar_37;
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform sampler2D _OffsetTex;
uniform highp vec4 _OffsetTex_ST;
uniform highp vec2 _OffsetSpeed;
uniform highp vec3 _OffsetIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
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
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * _OffsetSpeed) + ((_glesMultiTexCoord0.xy * _OffsetTex_ST.xy) + _OffsetTex_ST.zw));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_OffsetTex, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = _OffsetIntensity;
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesColor * tmpvar_13) * (tmpvar_15 * tmpvar_16)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_2.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_4 = _glesColor;
  tmpvar_5 = _glesMultiTexCoord0;
  tmpvar_6 = _glesMultiTexCoord1;
  tmpvar_7 = _glesMultiTexCoord2;
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = o_10;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp float _Opacity;
uniform highp vec4 _DepthColor;
uniform highp vec4 _MianColor;
uniform highp vec4 _DeepColor;
uniform highp vec4 _ShalowColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _WaterDepth;
uniform highp float _WaterFalloff;
uniform highp float _NormalScale;
uniform sampler2D _WaterNormal;
uniform highp vec4 _WaterNormalSpeed;
uniform sampler2D _WaterNormalMask;
uniform highp float _NormalMaskScale;
uniform highp vec4 _WaterNormal_ST;
uniform highp float _Distortion;
uniform highp vec4 _DistortionOffset;
uniform highp float _DepthDistance;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _CustomDepthTexture;
uniform highp float _FogValue;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec3 addFog_3;
  highp vec4 ase_screenPosNorm_4;
  highp vec4 screenColor65_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3);
  highp float z_7;
  z_7 = tmpvar_6.x;
  highp float tmpvar_8;
  tmpvar_8 = clamp (pow ((
    abs(((1.0/((
      (_ZBufferParams.z * z_7)
     + _ZBufferParams.w))) - xlv_TEXCOORD3.w))
   + 
    (_WaterDepth * 100.0)
  ), _WaterFalloff), 0.0, 1.0);
  highp vec4 o_9;
  o_9.xzw = xlv_TEXCOORD3.xzw;
  o_9.y = (xlv_TEXCOORD3.w * 0.5);
  o_9.y = (((xlv_TEXCOORD3.y - o_9.y) * _ProjectionParams.x) + o_9.y);
  highp float tmpvar_10;
  tmpvar_10 = (_NormalScale * 0.01);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _WaterNormal_ST.xy) + _WaterNormal_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_WaterNormalMask, xlv_TEXCOORD0.xy);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_Time.y * _WaterNormalSpeed.xy) + tmpvar_11);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((_Time.y * _WaterNormalSpeed.zw) + tmpvar_11);
  highp vec3 tmpvar_15;
  tmpvar_15.z = 0.0;
  tmpvar_15.xy = (o_9 / xlv_TEXCOORD3.w).xy;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_WaterNormal, tmpvar_13);
  mediump vec4 packednormal_17;
  packednormal_17 = tmpvar_16;
  mediump float bumpScale_18;
  bumpScale_18 = tmpvar_10;
  mediump vec3 normal_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((packednormal_17.xyz * 2.0) - 1.0);
  normal_19.z = tmpvar_20.z;
  normal_19.xy = (tmpvar_20.xy * bumpScale_18);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_WaterNormal, tmpvar_14);
  mediump vec4 packednormal_22;
  packednormal_22 = tmpvar_21;
  mediump float bumpScale_23;
  bumpScale_23 = tmpvar_10;
  mediump vec3 normal_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((packednormal_22.xyz * 2.0) - 1.0);
  normal_24.z = tmpvar_25.z;
  normal_24.xy = (tmpvar_25.xy * bumpScale_23);
  mediump vec3 tmpvar_26;
  tmpvar_26.xy = (normal_19.xy + normal_24.xy);
  tmpvar_26.z = (tmpvar_20.z * tmpvar_25.z);
  mediump vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_26);
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((tmpvar_15 + (
    (tmpvar_27 * _Distortion)
   * 
    (tmpvar_12 * _NormalMaskScale)
  .x)).xy + (_DistortionOffset.xy * 0.1));
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  screenColor65_5 = tmpvar_28;
  highp vec4 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm_4.xyw = tmpvar_30.xyw;
  ase_screenPosNorm_4.z = ((tmpvar_30.z * 0.5) + 0.5);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_32;
  z_32 = tmpvar_31.x;
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (_DepthColor, (_MianColor + mix (
    mix (_DeepColor, _ShalowColor, vec4(tmpvar_8))
  , screenColor65_5, vec4(tmpvar_8))), vec4(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_32)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_4.z)
     + _ZBufferParams.w)))) / _DepthDistance)
  ), 0.0, 1.0)));
  mediump vec3 srcColor_34;
  srcColor_34 = tmpvar_33.xyz;
  mediump vec3 tmpvar_35;
  tmpvar_35 = mix (srcColor_34, xlv_COLOR1.xyz, xlv_COLOR1.www);
  addFog_3 = tmpvar_35;
  aseOutAlpha_2 = _Opacity;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33.xyz, addFog_3, vec3(_FogValue));
  aseOutColor_1 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = aseOutColor_1;
  tmpvar_38.w = tmpvar_37;
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform sampler2D _OffsetTex;
uniform highp vec4 _OffsetTex_ST;
uniform highp vec2 _OffsetSpeed;
uniform highp vec3 _OffsetIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
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
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * _OffsetSpeed) + ((_glesMultiTexCoord0.xy * _OffsetTex_ST.xy) + _OffsetTex_ST.zw));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_OffsetTex, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = _OffsetIntensity;
  tmpvar_2.xyz = (_glesVertex.xyz + ((_glesColor * tmpvar_13) * (tmpvar_15 * tmpvar_16)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_2.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_4 = _glesColor;
  tmpvar_5 = _glesMultiTexCoord0;
  tmpvar_6 = _glesMultiTexCoord1;
  tmpvar_7 = _glesMultiTexCoord2;
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = o_10;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp float _Opacity;
uniform highp vec4 _DepthColor;
uniform highp vec4 _MianColor;
uniform highp vec4 _DeepColor;
uniform highp vec4 _ShalowColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _WaterDepth;
uniform highp float _WaterFalloff;
uniform highp float _NormalScale;
uniform sampler2D _WaterNormal;
uniform highp vec4 _WaterNormalSpeed;
uniform sampler2D _WaterNormalMask;
uniform highp float _NormalMaskScale;
uniform highp vec4 _WaterNormal_ST;
uniform highp float _Distortion;
uniform highp vec4 _DistortionOffset;
uniform highp float _DepthDistance;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _CustomDepthTexture;
uniform highp float _FogValue;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec3 addFog_3;
  highp vec4 ase_screenPosNorm_4;
  highp vec4 screenColor65_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3);
  highp float z_7;
  z_7 = tmpvar_6.x;
  highp float tmpvar_8;
  tmpvar_8 = clamp (pow ((
    abs(((1.0/((
      (_ZBufferParams.z * z_7)
     + _ZBufferParams.w))) - xlv_TEXCOORD3.w))
   + 
    (_WaterDepth * 100.0)
  ), _WaterFalloff), 0.0, 1.0);
  highp vec4 o_9;
  o_9.xzw = xlv_TEXCOORD3.xzw;
  o_9.y = (xlv_TEXCOORD3.w * 0.5);
  o_9.y = (((xlv_TEXCOORD3.y - o_9.y) * _ProjectionParams.x) + o_9.y);
  highp float tmpvar_10;
  tmpvar_10 = (_NormalScale * 0.01);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _WaterNormal_ST.xy) + _WaterNormal_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_WaterNormalMask, xlv_TEXCOORD0.xy);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_Time.y * _WaterNormalSpeed.xy) + tmpvar_11);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((_Time.y * _WaterNormalSpeed.zw) + tmpvar_11);
  highp vec3 tmpvar_15;
  tmpvar_15.z = 0.0;
  tmpvar_15.xy = (o_9 / xlv_TEXCOORD3.w).xy;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_WaterNormal, tmpvar_13);
  mediump vec4 packednormal_17;
  packednormal_17 = tmpvar_16;
  mediump float bumpScale_18;
  bumpScale_18 = tmpvar_10;
  mediump vec3 normal_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((packednormal_17.xyz * 2.0) - 1.0);
  normal_19.z = tmpvar_20.z;
  normal_19.xy = (tmpvar_20.xy * bumpScale_18);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_WaterNormal, tmpvar_14);
  mediump vec4 packednormal_22;
  packednormal_22 = tmpvar_21;
  mediump float bumpScale_23;
  bumpScale_23 = tmpvar_10;
  mediump vec3 normal_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((packednormal_22.xyz * 2.0) - 1.0);
  normal_24.z = tmpvar_25.z;
  normal_24.xy = (tmpvar_25.xy * bumpScale_23);
  mediump vec3 tmpvar_26;
  tmpvar_26.xy = (normal_19.xy + normal_24.xy);
  tmpvar_26.z = (tmpvar_20.z * tmpvar_25.z);
  mediump vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_26);
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((tmpvar_15 + (
    (tmpvar_27 * _Distortion)
   * 
    (tmpvar_12 * _NormalMaskScale)
  .x)).xy + (_DistortionOffset.xy * 0.1));
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  screenColor65_5 = tmpvar_28;
  highp vec4 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm_4.xyw = tmpvar_30.xyw;
  ase_screenPosNorm_4.z = ((tmpvar_30.z * 0.5) + 0.5);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_32;
  z_32 = tmpvar_31.x;
  highp vec4 tmpvar_33;
  tmpvar_33 = mix (_DepthColor, (_MianColor + mix (
    mix (_DeepColor, _ShalowColor, vec4(tmpvar_8))
  , screenColor65_5, vec4(tmpvar_8))), vec4(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_32)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_4.z)
     + _ZBufferParams.w)))) / _DepthDistance)
  ), 0.0, 1.0)));
  mediump vec3 srcColor_34;
  srcColor_34 = tmpvar_33.xyz;
  mediump vec3 tmpvar_35;
  tmpvar_35 = mix (srcColor_34, xlv_COLOR1.xyz, xlv_COLOR1.www);
  addFog_3 = tmpvar_35;
  aseOutAlpha_2 = _Opacity;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33.xyz, addFog_3, vec3(_FogValue));
  aseOutColor_1 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = aseOutColor_1;
  tmpvar_38.w = tmpvar_37;
  gl_FragData[0] = tmpvar_38;
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
CustomEditor "ASEMaterialInspector"
}