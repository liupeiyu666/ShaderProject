//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Water Transparent" {
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
_CausticVelocity ("Caustic Velocity", Vector) = (0,0,0,0)
_CausticScale ("Caustic Scale", Float) = 1
_CausticFresnelFactors ("Caustic Fresnel Factors", Vector) = (1,1,0,0)
_RefractionColor ("Fraction Color", Color) = (1,1,1,1)
_ReflectionFresnelFactors ("Reflection Fresnel Factors", Vector) = (1,1,0,0)
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 4617
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
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
  outcolor_1.w = _RefractionColor.w;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (xlv_TEXCOORD2 - (texoffset_2 * 5.0));
  tmpvar_6 = texture2D (_CausticMap, P_7);
  outcolor_1.xyz = (_RefractionColor.xyz + (tmpvar_6.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (_RefractionColor.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_22)
      ) * (_FogIntensity * tmpvar_22))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (_FogEndDistance - _FogStartDistance);
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, tmpvar_29))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_30;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase.xyz + (h_28 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_30 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  tmpvar_19 = tmpvar_22;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
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
  mediump float tmpvar_14;
  mediump vec3 I_15;
  I_15 = tmpvar_13;
  tmpvar_14 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_11);
  mediump float tmpvar_17;
  mediump vec3 I_18;
  I_18 = tmpvar_16;
  tmpvar_17 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_18.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_17;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_22;
  mediump float fogFactor_23;
  mediump vec3 fogColor_24;
  mediump vec3 heightFogColor_25;
  highp float HeightFogFactor_26;
  mediump vec3 atomesphereFogColor_27;
  mediump float h_28;
  highp float linearFogDensity_29;
  mediump float len_30;
  highp float tmpvar_31;
  tmpvar_31 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((len_30 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_29 = (tmpvar_32 * (2.0 - tmpvar_32));
  if ((len_30 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_29 = (linearFogDensity_29 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_33;
  tmpvar_33 = min (pow (linearFogDensity_29, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_29 = tmpvar_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_20.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  h_28 = (tmpvar_34 * (2.0 - tmpvar_34));
  highp vec3 tmpvar_36;
  tmpvar_36 = (_HeigtFogColBase2.xyz + (h_28 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_27 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (atomesphereFogColor_27, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_30 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_27 = tmpvar_37;
  mediump float tmpvar_38;
  mediump float r_39;
  mediump float f_40;
  mediump float u_41;
  mediump float l_42;
  mediump float fogInt_43;
  fogInt_43 = 1.0;
  highp float tmpvar_44;
  tmpvar_44 = (_HeigtFogParams2.x * tmpvar_21.y);
  highp float tmpvar_45;
  tmpvar_45 = abs(tmpvar_44);
  if ((tmpvar_45 > 0.01)) {
    highp float tmpvar_46;
    tmpvar_46 = exp(-(tmpvar_44));
    fogInt_43 = ((1.0 - tmpvar_46) / tmpvar_44);
  };
  highp float tmpvar_47;
  tmpvar_47 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_42 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (l_42 * _HeigtFogParams2.y);
  u_41 = tmpvar_48;
  fogInt_43 = (fogInt_43 * u_41);
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (((l_42 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  r_39 = (tmpvar_49 * (2.0 - tmpvar_49));
  r_39 = ((r_39 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_40 = ((1.0 - clamp (
    exp2(-(fogInt_43))
  , 0.0, 1.0)) * r_39);
  highp float tmpvar_51;
  tmpvar_51 = min (f_40, _HeigtFogColBase2.w);
  tmpvar_38 = tmpvar_51;
  HeightFogFactor_26 = tmpvar_38;
  highp vec3 tmpvar_52;
  tmpvar_52 = _Mihoyo_FogColor2.xyz;
  heightFogColor_25 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = ((heightFogColor_25 * HeightFogFactor_26) + ((atomesphereFogColor_27 * tmpvar_33) * (1.0 - HeightFogFactor_26)));
  fogColor_24 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = ((1.0 - tmpvar_33) * (1.0 - HeightFogFactor_26));
  fogFactor_23 = tmpvar_54;
  mediump vec4 tmpvar_55;
  tmpvar_55.xyz = fogColor_24;
  tmpvar_55.w = fogFactor_23;
  tmpvar_22 = tmpvar_55;
  highp vec4 tmpvar_56;
  mediump float fogFactor_57;
  mediump vec3 fogColor_58;
  mediump vec3 heightFogColor_59;
  highp float HeightFogFactor_60;
  mediump vec3 atomesphereFogColor_61;
  mediump float h_62;
  highp float linearFogDensity_63;
  mediump float len_64;
  highp float tmpvar_65;
  tmpvar_65 = sqrt(dot (tmpvar_21, tmpvar_21));
  len_64 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((len_64 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_63 = (tmpvar_66 * (2.0 - tmpvar_66));
  if ((len_64 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_63 = (linearFogDensity_63 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_67;
  tmpvar_67 = min (pow (linearFogDensity_63, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_63 = tmpvar_67;
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((tmpvar_20.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  h_62 = (tmpvar_68 * (2.0 - tmpvar_68));
  highp vec3 tmpvar_70;
  tmpvar_70 = (_HeigtFogColBase3.xyz + (h_62 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_61 = tmpvar_70;
  highp vec3 tmpvar_71;
  tmpvar_71 = mix (atomesphereFogColor_61, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_64 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_61 = tmpvar_71;
  mediump float tmpvar_72;
  mediump float r_73;
  mediump float f_74;
  mediump float u_75;
  mediump float l_76;
  mediump float fogInt_77;
  fogInt_77 = 1.0;
  highp float tmpvar_78;
  tmpvar_78 = (_HeigtFogParams3.x * tmpvar_21.y);
  highp float tmpvar_79;
  tmpvar_79 = abs(tmpvar_78);
  if ((tmpvar_79 > 0.01)) {
    highp float tmpvar_80;
    tmpvar_80 = exp(-(tmpvar_78));
    fogInt_77 = ((1.0 - tmpvar_80) / tmpvar_78);
  };
  highp float tmpvar_81;
  tmpvar_81 = sqrt(dot (tmpvar_21, tmpvar_21));
  l_76 = tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = (l_76 * _HeigtFogParams3.y);
  u_75 = tmpvar_82;
  fogInt_77 = (fogInt_77 * u_75);
  mediump float tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((l_76 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_83 = tmpvar_84;
  r_73 = (tmpvar_83 * (2.0 - tmpvar_83));
  r_73 = ((r_73 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_74 = ((1.0 - clamp (
    exp2(-(fogInt_77))
  , 0.0, 1.0)) * r_73);
  highp float tmpvar_85;
  tmpvar_85 = min (f_74, _HeigtFogColBase3.w);
  tmpvar_72 = tmpvar_85;
  HeightFogFactor_60 = tmpvar_72;
  highp vec3 tmpvar_86;
  tmpvar_86 = _Mihoyo_FogColor3.xyz;
  heightFogColor_59 = tmpvar_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = ((heightFogColor_59 * HeightFogFactor_60) + ((atomesphereFogColor_61 * tmpvar_67) * (1.0 - HeightFogFactor_60)));
  fogColor_58 = tmpvar_87;
  highp float tmpvar_88;
  tmpvar_88 = ((1.0 - tmpvar_67) * (1.0 - HeightFogFactor_60));
  fogFactor_57 = tmpvar_88;
  mediump vec4 tmpvar_89;
  tmpvar_89.xyz = fogColor_58;
  tmpvar_89.w = fogFactor_57;
  tmpvar_56 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = mix (tmpvar_22, tmpvar_56, vec4(_LerpFactor));
  tmpvar_19 = tmpvar_90;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec4 reflectionColor_2;
  mediump vec2 texoffset_3;
  mediump vec3 accNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((accNormal_4.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_3);
  tmpvar_7 = texture2D (_ReflectionTex, P_8);
  reflectionColor_2.xyz = (tmpvar_7 * _RefColor).xyz;
  reflectionColor_2.w = 1.0;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (_RefractionColor, reflectionColor_2, vec4(tmpvar_9));
  outcolor_1.w = tmpvar_10.w;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD2 - (texoffset_3 * 5.0));
  tmpvar_11 = texture2D (_CausticMap, P_12);
  outcolor_1.xyz = (tmpvar_10.xyz + (tmpvar_11.xyz * xlv_TEXCOORD4.w));
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outcolor_1.w = clamp (tmpvar_10.w, 0.0, 1.0);
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