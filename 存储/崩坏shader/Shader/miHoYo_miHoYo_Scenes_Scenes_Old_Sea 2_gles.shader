//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Sea 2" {
Properties {
_RefColor ("Reflection Color", Color) = (1,1,1,1)
_ReflectionTex ("Reflection", 2D) = "white" { }
_WaterColor ("Water Color (used when disable realtime reflection)", Color) = (0,0,0,0)
_NormalMap ("Normal Map", 2D) = "white" { }
_CausticMap ("Caustic Map", 2D) = "white" { }
_Distortion ("Distortion", Float) = 1
_BumpVelocity0 ("Bump Velocity 0", Vector) = (0,0,0,0)
_BumpScale0 ("Bump Scale 0", Float) = 1
_BumpVelocity1 ("Bump Velocity 1", Vector) = (0,0,0,0)
_BumpScale1 ("Bump Scale 1", Float) = 1
_Caustic ("Caustic", Float) = 1
_CausticVelocity ("Caustic Velocity", Vector) = (0,0,0,0)
_CausticScale ("Caustic Scale", Float) = 1
_RefractionColor ("Fraction Color", Color) = (1,1,1,1)
_FresnelFactors ("Fresnel Factors", Vector) = (1,1,0,0)
_BloomFactor ("Bloom Factor", Float) = 1
_GlitterTex ("Glitter Tex (R: Ocean Glitter)", 2D) = "white" { }
_NoiseTex ("Noise Tex (A)", 2D) = "white" { }
[Header(Ocean Glitter)] _OceanScintillationScaleLayer1 ("Glitter Scintillation Scale Layer 1", Range(0, 50)) = 5
_OceanScintillationSpeedLayer1 ("Glitter Scintillation Speed Layer 1", Range(0, 1)) = 0.3
_OceanScintillationScaleLayer2 ("Glitter Scintillation Scale Layer 2", Range(0, 50)) = 5
_OceanScintillationSpeedLayer2 ("Glitter Scintillation Speed Layer 2", Range(0, 1)) = 0.3
_InnerGlitterDensity ("Inner Glitter Density", Range(0, 1)) = 0.5
_InnerGlitterBrightness ("Inner Glitter Brightness", Range(0, 1000)) = 400
_OutsideGlitterDensity ("Outside Glitter Density", Range(0, 1)) = 0.5
_OutsideGlitterBrightness ("Outside Glitter Brightness", Range(0, 1000)) = 400
_InnerDensityRange ("Inner Density Range", Range(0, 1)) = 0.2
_OceanGlitterSpeed ("Glitter Speed", Range(0, 1)) = 0.1
_OceanGlitterColor ("Glitter Color", Color) = (1,1,1,1)
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 22080
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
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
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
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
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WaterColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  outcolor_5 = _WaterColor;
  lowp float tmpvar_10;
  tmpvar_10 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_10;
  highp float tmpvar_11;
  highp vec2 x_12;
  x_12 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_11 = sqrt(dot (x_12, x_12));
  xlat_vardistance_1 = tmpvar_11;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_13.xyz;
    lowp vec4 tmpvar_14;
    highp vec2 P_15;
    P_15 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_14 = texture2D (_NoiseTex, P_15);
    mediump float edge0_16;
    edge0_16 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_17;
    tmpvar_17 = clamp (((tmpvar_14.w - edge0_16) / (1.0 - edge0_16)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_17 * (tmpvar_17 * 
      (3.0 - (2.0 * tmpvar_17))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_18.xyz;
    lowp vec4 tmpvar_19;
    highp vec2 P_20;
    P_20 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_19 = texture2D (_NoiseTex, P_20);
    mediump float edge0_21;
    edge0_21 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_22;
    tmpvar_22 = clamp (((tmpvar_19.w - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_22 * (tmpvar_22 * 
      (3.0 - (2.0 * tmpvar_22))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_23 = texture2D (_CausticMap, P_24);
  outcolor_5.xyz = (_WaterColor.xyz + (tmpvar_23.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_6.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  tmpvar_7 = _glesMultiTexCoord0.xy;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_23;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_28)
      ) * (_FogIntensity * tmpvar_28))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_28)) * (_FogColorIntensity * tmpvar_28))
    ), 0.0, 1.0)));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_25 = fogColor_26;
  } else {
    mediump vec4 fogColor_31;
    highp vec3 tmpvar_32;
    tmpvar_32 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_33;
    tmpvar_33 = max (0.0, (sqrt(
      dot (tmpvar_32, tmpvar_32)
    ) - _FogStartDistance));
    highp float tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (_FogEndDistance - _FogStartDistance);
    tmpvar_34 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_33) / max (0.1, tmpvar_35))
    , 0.0, 1.0))));
    fogColor_31.xyz = tmpvar_36;
    fogColor_31.w = tmpvar_34;
    tmpvar_25 = fogColor_31;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = mix (outcolor_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase.xyz + (h_34 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_36 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  tmpvar_25 = tmpvar_28;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _FresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec4 _CausticVelocity;
uniform mediump float _CausticScale;
uniform highp vec4 _GlitterTex_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _OceanGlitterSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y).xy);
  mediump vec2 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (_OceanGlitterSpeed * _OceanScintillationSpeedLayer1);
  tmpvar_12.x = (tmpvar_13 * 0.4);
  tmpvar_12.y = (tmpvar_13 * 0.2);
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_OceanGlitterSpeed * _Time.y) * (_OceanScintillationSpeedLayer2 * 0.2));
  tmpvar_14.y = ((_OceanGlitterSpeed * _OceanScintillationSpeedLayer2) * 0.4);
  tmpvar_7.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15 = (_glesMultiTexCoord0.xy * _GlitterTex_ST.xy);
  highp vec2 tmpvar_16;
  tmpvar_16 = (_CausticVelocity.zw * _Time.y);
  tmpvar_8 = (tmpvar_15 + tmpvar_16);
  tmpvar_9 = (tmpvar_15 + tmpvar_16);
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_10.zw;
  highp vec3 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _WorldSpaceCameraPos;
  tmpvar_20 = ((unity_WorldToObject * tmpvar_21).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_20);
  mediump float tmpvar_23;
  mediump vec3 I_24;
  I_24 = tmpvar_22;
  tmpvar_23 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_24.z), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_6.x = tmpvar_23;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_20, tmpvar_20)), 0.5);
  mediump vec4 tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_28;
  mediump float fogFactor_29;
  mediump vec3 fogColor_30;
  mediump vec3 heightFogColor_31;
  highp float HeightFogFactor_32;
  mediump vec3 atomesphereFogColor_33;
  mediump float h_34;
  highp float linearFogDensity_35;
  mediump float len_36;
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((len_36 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_35 = (tmpvar_38 * (2.0 - tmpvar_38));
  if ((len_36 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_35 = (linearFogDensity_35 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_39;
  tmpvar_39 = min (pow (linearFogDensity_35, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_35 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((tmpvar_26.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  h_34 = (tmpvar_40 * (2.0 - tmpvar_40));
  highp vec3 tmpvar_42;
  tmpvar_42 = (_HeigtFogColBase2.xyz + (h_34 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_33 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (atomesphereFogColor_33, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_36 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  mediump float r_45;
  mediump float f_46;
  mediump float u_47;
  mediump float l_48;
  mediump float fogInt_49;
  fogInt_49 = 1.0;
  highp float tmpvar_50;
  tmpvar_50 = (_HeigtFogParams2.x * tmpvar_27.y);
  highp float tmpvar_51;
  tmpvar_51 = abs(tmpvar_50);
  if ((tmpvar_51 > 0.01)) {
    highp float tmpvar_52;
    tmpvar_52 = exp(-(tmpvar_50));
    fogInt_49 = ((1.0 - tmpvar_52) / tmpvar_50);
  };
  highp float tmpvar_53;
  tmpvar_53 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_48 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (l_48 * _HeigtFogParams2.y);
  u_47 = tmpvar_54;
  fogInt_49 = (fogInt_49 * u_47);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((l_48 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  r_45 = (tmpvar_55 * (2.0 - tmpvar_55));
  r_45 = ((r_45 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_46 = ((1.0 - clamp (
    exp2(-(fogInt_49))
  , 0.0, 1.0)) * r_45);
  highp float tmpvar_57;
  tmpvar_57 = min (f_46, _HeigtFogColBase2.w);
  tmpvar_44 = tmpvar_57;
  HeightFogFactor_32 = tmpvar_44;
  highp vec3 tmpvar_58;
  tmpvar_58 = _Mihoyo_FogColor2.xyz;
  heightFogColor_31 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((heightFogColor_31 * HeightFogFactor_32) + ((atomesphereFogColor_33 * tmpvar_39) * (1.0 - HeightFogFactor_32)));
  fogColor_30 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = ((1.0 - tmpvar_39) * (1.0 - HeightFogFactor_32));
  fogFactor_29 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = fogColor_30;
  tmpvar_61.w = fogFactor_29;
  tmpvar_28 = tmpvar_61;
  highp vec4 tmpvar_62;
  mediump float fogFactor_63;
  mediump vec3 fogColor_64;
  mediump vec3 heightFogColor_65;
  highp float HeightFogFactor_66;
  mediump vec3 atomesphereFogColor_67;
  mediump float h_68;
  highp float linearFogDensity_69;
  mediump float len_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_27, tmpvar_27));
  len_70 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = clamp (((len_70 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_69 = (tmpvar_72 * (2.0 - tmpvar_72));
  if ((len_70 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_69 = (linearFogDensity_69 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_73;
  tmpvar_73 = min (pow (linearFogDensity_69, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_69 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (((tmpvar_26.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  h_68 = (tmpvar_74 * (2.0 - tmpvar_74));
  highp vec3 tmpvar_76;
  tmpvar_76 = (_HeigtFogColBase3.xyz + (h_68 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_67 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = mix (atomesphereFogColor_67, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_70 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_67 = tmpvar_77;
  mediump float tmpvar_78;
  mediump float r_79;
  mediump float f_80;
  mediump float u_81;
  mediump float l_82;
  mediump float fogInt_83;
  fogInt_83 = 1.0;
  highp float tmpvar_84;
  tmpvar_84 = (_HeigtFogParams3.x * tmpvar_27.y);
  highp float tmpvar_85;
  tmpvar_85 = abs(tmpvar_84);
  if ((tmpvar_85 > 0.01)) {
    highp float tmpvar_86;
    tmpvar_86 = exp(-(tmpvar_84));
    fogInt_83 = ((1.0 - tmpvar_86) / tmpvar_84);
  };
  highp float tmpvar_87;
  tmpvar_87 = sqrt(dot (tmpvar_27, tmpvar_27));
  l_82 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = (l_82 * _HeigtFogParams3.y);
  u_81 = tmpvar_88;
  fogInt_83 = (fogInt_83 * u_81);
  mediump float tmpvar_89;
  highp float tmpvar_90;
  tmpvar_90 = clamp (((l_82 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_89 = tmpvar_90;
  r_79 = (tmpvar_89 * (2.0 - tmpvar_89));
  r_79 = ((r_79 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_80 = ((1.0 - clamp (
    exp2(-(fogInt_83))
  , 0.0, 1.0)) * r_79);
  highp float tmpvar_91;
  tmpvar_91 = min (f_80, _HeigtFogColBase3.w);
  tmpvar_78 = tmpvar_91;
  HeightFogFactor_66 = tmpvar_78;
  highp vec3 tmpvar_92;
  tmpvar_92 = _Mihoyo_FogColor3.xyz;
  heightFogColor_65 = tmpvar_92;
  highp vec3 tmpvar_93;
  tmpvar_93 = ((heightFogColor_65 * HeightFogFactor_66) + ((atomesphereFogColor_67 * tmpvar_73) * (1.0 - HeightFogFactor_66)));
  fogColor_64 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = ((1.0 - tmpvar_73) * (1.0 - HeightFogFactor_66));
  fogFactor_63 = tmpvar_94;
  mediump vec4 tmpvar_95;
  tmpvar_95.xyz = fogColor_64;
  tmpvar_95.w = fogFactor_63;
  tmpvar_62 = tmpvar_95;
  highp vec4 tmpvar_96;
  tmpvar_96 = mix (tmpvar_28, tmpvar_62, vec4(_LerpFactor));
  tmpvar_25 = tmpvar_96;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_17;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
  xlv_COLOR1 = tmpvar_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
uniform sampler2D _GlitterTex;
uniform sampler2D _NoiseTex;
uniform mediump float _InnerGlitterDensity;
uniform mediump float _InnerGlitterBrightness;
uniform mediump float _OutsideGlitterDensity;
uniform mediump float _OutsideGlitterBrightness;
uniform mediump float _InnerDensityRange;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float xlat_vardistance_1;
  mediump vec3 glitterTex_2;
  mediump float oceanGlitterDensity_3;
  mediump float oceanGiltterScintillation_4;
  mediump vec4 outcolor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * _RefColor);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, tmpvar_12, vec4((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z)));
  outcolor_5 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_NoiseTex, xlv_TEXCOORD5.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD5.zw).w) * 3.0);
  oceanGiltterScintillation_4 = tmpvar_14;
  highp float tmpvar_15;
  highp vec2 x_16;
  x_16 = (xlv_TEXCOORD6 - vec2(0.5, 0.5));
  tmpvar_15 = sqrt(dot (x_16, x_16));
  xlat_vardistance_1 = tmpvar_15;
  if ((xlat_vardistance_1 > _InnerDensityRange)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_GlitterTex, xlv_TEXCOORD8);
    glitterTex_2 = tmpvar_17.xyz;
    lowp vec4 tmpvar_18;
    highp vec2 P_19;
    P_19 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_18 = texture2D (_NoiseTex, P_19);
    mediump float edge0_20;
    edge0_20 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _OutsideGlitterDensity);
    mediump float tmpvar_21;
    tmpvar_21 = clamp (((tmpvar_18.w - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_21 * (tmpvar_21 * 
      (3.0 - (2.0 * tmpvar_21))
    )) * _OutsideGlitterBrightness);
  } else {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_GlitterTex, xlv_TEXCOORD7);
    glitterTex_2 = tmpvar_22.xyz;
    lowp vec4 tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD5.xy * 10.0);
    tmpvar_23 = texture2D (_NoiseTex, P_24);
    mediump float edge0_25;
    edge0_25 = ((1.0 - (
      (xlat_vardistance_1 * xlat_vardistance_1)
     * 3.0)) * _InnerGlitterDensity);
    mediump float tmpvar_26;
    tmpvar_26 = clamp (((tmpvar_23.w - edge0_25) / (1.0 - edge0_25)), 0.0, 1.0);
    oceanGlitterDensity_3 = ((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )) * _InnerGlitterBrightness);
  };
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_27 = texture2D (_CausticMap, P_28);
  outcolor_5.xyz = (outcolor_5.xyz + (tmpvar_27.xyz * _Caustic));
  outcolor_5.xyz = (outcolor_5.xyz + ((glitterTex_2.x * _OceanGlitterColor) * (oceanGlitterDensity_3 * oceanGiltterScintillation_4)));
  outcolor_5.xyz = (xlv_COLOR1.xyz + (outcolor_5.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_5.w = _BloomFactor;
  outcolor_5.xyz = mix (outcolor_5.xyz, vec3(dot (outcolor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outcolor_5;
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
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
}
}
}
}