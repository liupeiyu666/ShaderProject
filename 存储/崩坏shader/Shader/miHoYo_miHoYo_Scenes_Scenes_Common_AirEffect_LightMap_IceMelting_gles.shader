//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/AirEffect_LightMap_IceMelting" {
Properties {
[MHYHeaderBox(Ice)] _MainColor ("Ice Color", Color) = (1,1,1,1)
_MainTex ("Ice Tex (RGB)", 2D) = "white" { }
_ShadowTex ("Ice LightMap (RGB)", 2D) = "grey" { }
_LightMapIntensity ("Ice Light Map Intensity", Float) = 1
[MHYHeaderBox(Ice Melting)] _IceMelting ("Ice Melting", Range(0, 1)) = 0
_MeltY ("Ice Melt Height", Float) = 0
_MeltRange ("Ice Melt Range", Range(0.001, 1)) = 0.2
_MeltCurve ("Ice Melt Curve", Range(1, 10)) = 2
[MHYHeaderBox(Water)] _WaterColor ("Water Color(Alpha = Water Trasprent)", Color) = (1,1,1,1)
_Fresnel0 ("Water Fresnel", Range(0, 1)) = 0.4
_WaterNormal ("Water Normal", 2D) = "bump" { }
_WaterNormalScale ("Water Normal Scale", Range(0, 2)) = 1
_WaterRefTex ("Water Reflection Tex", Cube) = "white" { }
_WaterRefColor ("Water Reflection Color", Color) = (1,1,1,1)
_WaterRefScale ("Water Reflection Scale", Range(1, 10)) = 1
_WaterRefIntensity ("Water Reflection Intensity", Range(1, 3)) = 1
[MHYHeaderBox(Water Dynamic)] _Speed ("Water Speed", Range(0.001, 2)) = 0.5
_Frequency ("Water Frequency", Range(1, 100)) = 20
_Delta1 ("Water Delta1", Range(0, 0.1)) = 0.01
_Delta2 ("Water Delta2", Range(0, 0.1)) = 0.01
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 45404
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_18;
  highp float pixelMelt_19;
  highp float melt_20;
  highp vec4 worldSpacePosition_21;
  worldSpacePosition_21.yw = tmpvar_17.yw;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = tmpvar_1;
  melt_20 = (1.0 - clamp ((
    (tmpvar_17.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_19 = melt_20;
  highp float tmpvar_23;
  tmpvar_23 = pow (melt_20, _MeltCurve);
  melt_20 = tmpvar_23;
  worldSpacePosition_21.xz = (tmpvar_17.xz + ((unity_ObjectToWorld * tmpvar_22).xz * tmpvar_23));
  tmpvar_18 = (unity_WorldToObject * worldSpacePosition_21);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_26.yw = tmpvar_27.yw;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_27.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_29;
  tmpvar_29 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_29;
  worldSpacePosition_26.xz = (tmpvar_27.xz + ((unity_ObjectToWorld * tmpvar_28).xz * tmpvar_29));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_24 * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp vec4 tmpvar_35;
  tmpvar_35 = ((unity_WorldToObject * worldSpacePosition_26) - tmpvar_18);
  highp vec4 tmpvar_36;
  tmpvar_36 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_18);
  tmpvar_1 = ((tmpvar_35.yzx * tmpvar_36.zxy) - (tmpvar_35.zxy * tmpvar_36.yzx));
  highp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = tmpvar_18.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_37));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_19;
  xlv_TEXCOORD3 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = mix (colorBlendLightMap_6, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _WaterNormalScale;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  N_5 = normal_23;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(N_5.xzy);
  N_5 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = abs(V_4.y);
  VdotN_3 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(_Fresnel0);
  highp vec3 f0_29;
  f0_29 = tmpvar_28;
  highp float tmpvar_30;
  tmpvar_30 = (1.0 - VdotN_3);
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_30 * tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_30 * tmpvar_31) * tmpvar_31);
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(V_4);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_25, I_34)
   * tmpvar_25)));
  R_2 = tmpvar_33;
  mediump vec3 tmpvar_35;
  tmpvar_35.z = 0.0;
  tmpvar_35.xy = tmpvar_17;
  lowp vec4 tmpvar_36;
  highp vec3 P_37;
  P_37 = ((R_2 + tmpvar_35) * _WaterRefScale);
  tmpvar_36 = textureCube (_WaterRefTex, P_37);
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_38;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = (((
    clamp (((f0_29 * (1.0 - tmpvar_32)) + vec3(tmpvar_32)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_39.w = _WaterColor.w;
  highp vec4 tmpvar_40;
  tmpvar_40 = mix ((outColor_11 * _MainColor), tmpvar_39, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_40;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump float _MeltY;
uniform mediump float _MeltRange;
uniform mediump float _MeltCurve;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  highp vec4 tmpvar_23;
  highp float pixelMelt_24;
  highp float melt_25;
  highp vec4 worldSpacePosition_26;
  worldSpacePosition_26.yw = tmpvar_18.yw;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_1;
  melt_25 = (1.0 - clamp ((
    (tmpvar_18.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  pixelMelt_24 = melt_25;
  highp float tmpvar_28;
  tmpvar_28 = pow (melt_25, _MeltCurve);
  melt_25 = tmpvar_28;
  worldSpacePosition_26.xz = (tmpvar_18.xz + ((unity_ObjectToWorld * tmpvar_27).xz * tmpvar_28));
  tmpvar_23 = (unity_WorldToObject * worldSpacePosition_26);
  highp vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  highp float melt_30;
  highp vec4 worldSpacePosition_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * (_glesVertex + (_glesTANGENT * 0.01)));
  worldSpacePosition_31.yw = tmpvar_32.yw;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_1;
  melt_30 = (1.0 - clamp ((
    (tmpvar_32.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_34;
  tmpvar_34 = pow (melt_30, _MeltCurve);
  melt_30 = tmpvar_34;
  worldSpacePosition_31.xz = (tmpvar_32.xz + ((unity_ObjectToWorld * tmpvar_33).xz * tmpvar_34));
  highp float melt_35;
  highp vec4 worldSpacePosition_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * (_glesVertex + (tmpvar_29 * 0.01)));
  worldSpacePosition_36.yw = tmpvar_37.yw;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 0.0;
  tmpvar_38.xyz = tmpvar_1;
  melt_35 = (1.0 - clamp ((
    (tmpvar_37.y - _MeltY)
   / _MeltRange), 0.0, 1.0));
  highp float tmpvar_39;
  tmpvar_39 = pow (melt_35, _MeltCurve);
  melt_35 = tmpvar_39;
  worldSpacePosition_36.xz = (tmpvar_37.xz + ((unity_ObjectToWorld * tmpvar_38).xz * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = ((unity_WorldToObject * worldSpacePosition_31) - tmpvar_23);
  highp vec4 tmpvar_41;
  tmpvar_41 = ((unity_WorldToObject * worldSpacePosition_36) - tmpvar_23);
  tmpvar_1 = ((tmpvar_40.yzx * tmpvar_41.zxy) - (tmpvar_40.zxy * tmpvar_41.yzx));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_23.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_2;
  xlv_TEXCOORD2 = pixelMelt_24;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = fogParam_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _IceMelting;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _Delta2;
uniform highp vec4 _WaterColor;
uniform mediump float _Fresnel0;
uniform sampler2D _WaterNormal;
uniform highp float _WaterNormalScale;
uniform lowp samplerCube _WaterRefTex;
uniform highp float _WaterRefScale;
uniform highp float _WaterRefIntensity;
uniform highp vec4 _WaterRefColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 reflection_1;
  mediump vec3 R_2;
  highp float VdotN_3;
  mediump vec3 V_4;
  highp vec3 N_5;
  mediump vec3 colorBlendLightMap_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  mediump float dy_9;
  mediump float dx_10;
  mediump vec4 outColor_11;
  outColor_11.w = 0.0;
  highp float coord_12;
  coord_12 = xlv_TEXCOORD0.x;
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y * _Speed);
  coord_12 = (coord_12 + tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = (cos((coord_12 * _Frequency)) * _Delta1);
  dx_10 = tmpvar_14;
  highp float coord_15;
  coord_15 = xlv_TEXCOORD0.y;
  coord_15 = (coord_15 + tmpvar_13);
  highp float tmpvar_16;
  tmpvar_16 = (cos((coord_15 * _Frequency)) * _Delta2);
  dy_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dx_10;
  tmpvar_17.y = dy_9;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_7 = tmpvar_19;
  colorBlendLightMap_6 = ((tex_C_Color_8.xyz * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  outColor_11.xyz = colorBlendLightMap_6;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_20;
    xlat_varinput_20 = xlv_TEXCOORD4;
    mediump vec3 fogParam_21;
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_22))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_24;
    tmpvar_24 = clamp ((_UWFogColorHLIntensity * tmpvar_22), 0.0, 1.0);
    fogParam_21.z = 0.0;
    fogParam_21.y = tmpvar_23;
    fogParam_21.x = tmpvar_24;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_20.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_22 * _UWHeightRatio)));
      highp float tmpvar_25;
      tmpvar_25 = clamp (xlat_varinput_20.y, _UWCriticalRange, 1.0);
      xlat_varinput_20.y = tmpvar_25;
    };
    fogParam_21.z = (1.0 - xlat_varinput_20.y);
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_11.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_26, fogParam_21.zzzz).xyz;
    outColor_11.xyz = tmpvar_27;
    mediump vec4 tmpvar_28;
    tmpvar_28.w = 0.0;
    tmpvar_28.xyz = outColor_11.xyz;
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_21.xxxx), tmpvar_28, fogParam_21.yyyy).xyz;
    outColor_11.xyz = tmpvar_29;
  };
  outColor_11.xyz = mix (outColor_11.xyz, vec3(dot (outColor_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_WaterNormal, xlv_TEXCOORD0);
  mediump vec4 packednormal_31;
  packednormal_31 = tmpvar_30;
  mediump float bumpScale_32;
  bumpScale_32 = _WaterNormalScale;
  mediump vec3 normal_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((packednormal_31.xyz * 2.0) - 1.0);
  normal_33.z = tmpvar_34.z;
  normal_33.xy = (tmpvar_34.xy * bumpScale_32);
  N_5 = normal_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(N_5.xzy);
  N_5 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  V_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(V_4.y);
  VdotN_3 = tmpvar_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = vec3(_Fresnel0);
  highp vec3 f0_39;
  f0_39 = tmpvar_38;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - VdotN_3);
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = ((tmpvar_40 * tmpvar_41) * tmpvar_41);
  highp vec3 tmpvar_43;
  mediump vec3 I_44;
  I_44 = -(V_4);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_35, I_44)
   * tmpvar_35)));
  R_2 = tmpvar_43;
  mediump vec3 tmpvar_45;
  tmpvar_45.z = 0.0;
  tmpvar_45.xy = tmpvar_17;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = ((R_2 + tmpvar_45) * _WaterRefScale);
  tmpvar_46 = textureCube (_WaterRefTex, P_47);
  highp vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_46.xyz * _WaterRefColor.xyz);
  reflection_1 = tmpvar_48;
  outColor_11.w = 1.0;
  highp vec4 tmpvar_49;
  tmpvar_49.xyz = (((
    clamp (((f0_39 * (1.0 - tmpvar_42)) + vec3(tmpvar_42)), 0.0, 1.0)
   * reflection_1) * _WaterColor.xyz) * _WaterRefIntensity);
  tmpvar_49.w = _WaterColor.w;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix ((outColor_11 * _MainColor), tmpvar_49, vec4((_IceMelting * xlv_TEXCOORD2)));
  outColor_11 = tmpvar_50;
  outColor_11.w = clamp (outColor_11.w, 0.0, 1.0);
  gl_FragData[0] = outColor_11;
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
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
}
}
}
Fallback "Diffuse"
}