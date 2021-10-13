//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "hidden/Scene/Water Shore (without reflection)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
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
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 37651
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
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
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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
attribute vec3 _glesNormal;
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
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0 * _BumpScale0).xy + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0 * _BumpScale1).xy + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0 * _CausticScale).xy + (_CausticVelocity * _Time.y));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = ((unity_WorldToObject * tmpvar_12).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_11);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(_glesNormal);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_13;
  mediump vec3 N_17;
  N_17 = tmpvar_14;
  tmpvar_15 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_16, N_17)), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _LumiFactor;
uniform mediump vec4 _WaterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec2 texoffset_2;
  mediump vec3 accNormal_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_3 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((accNormal_3.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (_RefractionColor, _WaterColor, xlv_TEXCOORD4.xxxx);
  outcolor_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_7 = texture2D (_CausticMap, P_8);
  outcolor_1.xyz = (outcolor_1.xyz + (tmpvar_7.xyz * _Caustic));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = xlv_TEXCOORD4.z;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (outcolor_1.w, 0.0, 1.0);
  gl_FragData[0] = outcolor_1;
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