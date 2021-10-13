//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Curtain (Wind)" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_Opacity ("Opacity", Range(0, 1)) = 1
_WindMagnitude ("Wind Magnitude", Float) = 0
_WindMagnitudeLimit ("Wind Magnitude Limit", Float) = 0.1
_WindFrequency ("Wind Frequency", Float) = 1
_WindWaveVelocity ("Wind Wave Velocity", Float) = 1
_WindDirection ("Wind Direction", Vector) = (1,0,0,0)
_WindMultiMagnitude ("Wind Multi-Magnitude", Vector) = (1,0.5,0.25,0.125)
_WindMultiFrequency ("Wind Multi-Frequency", Vector) = (1.975,0.793,0.375,0.193)
_WindMultiWaveVelocity ("Wind Multi-Wave Velocity", Vector) = (1,1,1,1)
_RadialWind1 ("Radial Wind 1", Vector) = (0,0,0,1)
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 6610
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_16;
  vert_16.w = tmpvar_1.w;
  highp float height_17;
  height_17 = tmpvar_2.x;
  highp vec3 radialWindDir1_18;
  highp vec3 offset_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WindDirection);
  highp vec4 tmpvar_21;
  tmpvar_21 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_20, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_18.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_18.y = 0.0;
  highp float tmpvar_22;
  tmpvar_22 = max (sqrt(dot (radialWindDir1_18, radialWindDir1_18)), 0.01);
  radialWindDir1_18 = (radialWindDir1_18 / tmpvar_22);
  highp float y_over_x_23;
  y_over_x_23 = ((tmpvar_22 - 5.0) * 4.0);
  highp float tmpvar_24;
  tmpvar_24 = (min (abs(y_over_x_23), 1.0) / max (abs(y_over_x_23), 1.0));
  highp float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  tmpvar_25 = (((
    ((((
      ((((-0.01213232 * tmpvar_25) + 0.05368138) * tmpvar_25) - 0.1173503)
     * tmpvar_25) + 0.1938925) * tmpvar_25) - 0.3326756)
   * tmpvar_25) + 0.9999793) * tmpvar_24);
  tmpvar_25 = (tmpvar_25 + (float(
    (abs(y_over_x_23) > 1.0)
  ) * (
    (tmpvar_25 * -2.0)
   + 1.570796)));
  offset_19 = ((tmpvar_20 * dot (
    (((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_18 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_25 * sign(y_over_x_23)))
  ) * height_17));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(dot (offset_19, offset_19));
  offset_19 = (offset_19 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_26) + log(_WindMagnitudeLimit)))
  ) / tmpvar_26));
  offset_19 = (offset_19 * (_WindMagnitude * height_17));
  vert_16.xyz = (tmpvar_1.xyz + offset_19);
  tmpvar_1 = vert_16;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * vert_16);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _Opacity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = (_BloomFactor * _Opacity);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
}
}
}
}