//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Grass_Lightmap_CamClip (Wind)" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_LightMapIntensity ("Light Map Intensity", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_WindMagnitude ("Wind Magnitude", Float) = 0
_WindMagnitudeLimit ("Wind Magnitude Limit", Float) = 0.1
_WindFrequency ("Wind Frequency", Float) = 1
_WindWaveVelocity ("Wind Wave Velocity", Float) = 1
_WindDirection ("Wind Direction", Vector) = (1,0,0,0)
_WindMultiMagnitude ("Wind Multi-Magnitude", Vector) = (1,0.5,0.25,0.125)
_WindMultiFrequency ("Wind Multi-Frequency", Vector) = (1.975,0.793,0.375,0.193)
_WindMultiWaveVelocity ("Wind Multi-Wave Velocity", Vector) = (1,1,1,1)
_RadialWind1 ("Radial Wind 1", Vector) = (0,0,0,1)
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 44177
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = xlv_TEXCOORD3;
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = xlv_TEXCOORD3;
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = xlv_TEXCOORD3;
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = xlv_TEXCOORD3;
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = xlv_TEXCOORD3;
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _WindMagnitude;
uniform highp float _WindFrequency;
uniform highp float _WindWaveVelocity;
uniform highp float _WindMagnitudeLimit;
uniform highp vec3 _WindDirection;
uniform highp vec4 _WindMultiMagnitude;
uniform highp vec4 _WindMultiFrequency;
uniform highp vec4 _WindMultiWaveVelocity;
uniform highp vec4 _RadialWind1;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesVertex;
  tmpvar_2 = _glesColor;
  mediump vec2 tmpvar_3;
  mediump float tmpvar_4;
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_1 = (tmpvar_1 / tmpvar_1.w);
  highp vec4 vert_17;
  vert_17.w = tmpvar_1.w;
  highp float height_18;
  height_18 = tmpvar_2.x;
  highp vec3 radialWindDir1_19;
  highp vec3 offset_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WindDirection);
  highp vec4 tmpvar_22;
  tmpvar_22 = abs(((
    fract((((
      (_Time.y * _WindFrequency)
     * _WindMultiFrequency) + (
      (dot (tmpvar_21, tmpvar_1.xyz) * _WindWaveVelocity)
     * _WindMultiWaveVelocity)) + 0.5))
   * 2.0) - 1.0));
  radialWindDir1_19.xz = (tmpvar_1.xyz - _RadialWind1.xyz).xz;
  radialWindDir1_19.y = 0.0;
  highp float tmpvar_23;
  tmpvar_23 = max (sqrt(dot (radialWindDir1_19, radialWindDir1_19)), 0.01);
  radialWindDir1_19 = (radialWindDir1_19 / tmpvar_23);
  highp float y_over_x_24;
  y_over_x_24 = ((tmpvar_23 - 5.0) * 4.0);
  highp float tmpvar_25;
  tmpvar_25 = (min (abs(y_over_x_24), 1.0) / max (abs(y_over_x_24), 1.0));
  highp float tmpvar_26;
  tmpvar_26 = (tmpvar_25 * tmpvar_25);
  tmpvar_26 = (((
    ((((
      ((((-0.01213232 * tmpvar_26) + 0.05368138) * tmpvar_26) - 0.1173503)
     * tmpvar_26) + 0.1938925) * tmpvar_26) - 0.3326756)
   * tmpvar_26) + 0.9999793) * tmpvar_25);
  tmpvar_26 = (tmpvar_26 + (float(
    (abs(y_over_x_24) > 1.0)
  ) * (
    (tmpvar_26 * -2.0)
   + 1.570796)));
  offset_20 = ((tmpvar_21 * dot (
    (((tmpvar_22 * tmpvar_22) * (3.0 - (2.0 * tmpvar_22))) - 0.5)
  , _WindMultiMagnitude)) + ((
    (radialWindDir1_19 * _RadialWind1.w)
   * 
    (1.58 - (tmpvar_26 * sign(y_over_x_24)))
  ) * height_18));
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (offset_20, offset_20));
  offset_20 = (offset_20 * ((_WindMagnitudeLimit - 
    exp((-(tmpvar_27) + log(_WindMagnitudeLimit)))
  ) / tmpvar_27));
  offset_20 = (offset_20 * (_WindMagnitude * height_18));
  vert_17.xyz = (tmpvar_1.xyz + offset_20);
  tmpvar_1 = vert_17;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    (-((unity_MatrixMV * vert_17).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_4 = tmpvar_28;
  gl_Position = (unity_MatrixVP * vert_17);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _Cutoff;
uniform mediump float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_4;
  mediump float x_5;
  x_5 = (col_2.w - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  col_2.xyz = mix (((col_2.xyz * 
    ((((2.0 * tex_S_Color_1.xyz) * tex_S_Color_1.w) + 1.0) - tex_S_Color_1.w)
  ) * _LightMapIntensity), xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_2.w = xlv_TEXCOORD3;
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  gl_FragData[0] = col_2;
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