//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Water (without reflection)" {
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
 LOD 300
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 300
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 11521
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_16 = tmpvar_19;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_16 = tmpvar_19;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_16 = tmpvar_19;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_17.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_87;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_17.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_87;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_17.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_87;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_16 = tmpvar_19;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_16 = tmpvar_19;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_16 = tmpvar_19;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_17.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_87;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_17.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_87;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
  tmpvar_14 = (_FresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_15.y), 0.001, 1.0), _FresnelFactors.x)
   * _FresnelFactors.y)));
  tmpvar_5.x = tmpvar_14;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_11, tmpvar_11)), 0.5);
  mediump vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_17.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_17.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_87;
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_8;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform mediump float _Caustic;
uniform mediump float _BloomFactor;
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
  outcolor_1.w = _BloomFactor;
  outcolor_1.xyz = mix (outcolor_1.xyz, vec3(dot (outcolor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
}
}
}
}