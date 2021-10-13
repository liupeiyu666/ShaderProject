//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/River" {
Properties {
_RefractionColor ("Fraction Color", Color) = (1,1,1,1)
_NormalMap ("Normal Map", 2D) = "white" { }
_CausticMap ("Caustic Map", 2D) = "white" { }
_Distortion ("Distortion", Float) = 1
_BumpVelocity0 ("Bump Velocity 0", Vector) = (0,0,0,0)
_BumpScale0 ("Bump UV Scale 0 (XY)", Vector) = (1,1,0,0)
_BumpVelocity1 ("Bump Velocity 1", Vector) = (0,0,0,0)
_BumpScale1 ("Bump UV Scale 1 (XY)", Vector) = (1,1,0,0)
_CausticVelocity ("Caustic Velocity", Vector) = (0,0,0,0)
_CausticScale ("Caustic UV Scale (XY)", Vector) = (1,1,0,0)
_CausticFresnelFactors ("Caustic Fresnel Factors", Vector) = (1,1,0,0)
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 2800
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_12 = tmpvar_15;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_12 = tmpvar_15;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_12 = tmpvar_15;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_12 = tmpvar_83;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_12 = tmpvar_83;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_12 = tmpvar_83;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  tmpvar_6.x = tmpvar_1.w;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = mix (outcolor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_12 = tmpvar_15;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_12 = tmpvar_15;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_12 = tmpvar_15;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_12 = tmpvar_83;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_12 = tmpvar_83;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump vec2 _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump vec2 _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump vec2 _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_WorldToObject * tmpvar_8).xyz - _glesVertex.xyz));
  mediump float tmpvar_10;
  mediump vec3 I_11;
  I_11 = tmpvar_9;
  tmpvar_10 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_11.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.y = tmpvar_10;
  mediump vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_12 = tmpvar_83;
  tmpvar_5.x = tmpvar_1.w;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_12;
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
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 outcolor_1;
  mediump vec3 accNormal_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_2 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = (accNormal_2.xy * _Distortion);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD2 - tmpvar_4);
  tmpvar_5 = texture2D (_CausticMap, P_6);
  outcolor_1.xyz = (_RefractionColor.xyz + ((tmpvar_5.xyz * xlv_TEXCOORD3.x) * xlv_TEXCOORD3.y));
  outcolor_1.w = (_RefractionColor.w * xlv_TEXCOORD3.x);
  outcolor_1.xyz = (xlv_COLOR1.xyz + (outcolor_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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