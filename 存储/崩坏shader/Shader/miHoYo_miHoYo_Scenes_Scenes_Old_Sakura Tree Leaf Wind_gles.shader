//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Sakura Tree Leaf Wind" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_WindDirection ("Wind Direction", Vector) = (1,0,0,0)
_BendIntensity ("Bend Intensity", Range(0, 1)) = 0.5
_BendSpeed ("Bend Speed", Range(0, 10)) = 0
_SideBendIntensity ("Side Bend Intensity", Range(0, 1)) = 0
_SideBendVariance ("Bend Variance", Float) = 1
_SideBendSoftness ("Side Bend Softness", Range(0, 10)) = 6
_DownBendIntensity ("Down Bend Intensity", Range(0, 1)) = 0
_DownBendVariance ("Down Bend Variance", Float) = 1
_Gust ("Gust", Float) = 0
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 56239
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams1;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 posInW_3;
  highp vec3 tmpvar_4;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_4 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_4 = _WindDirection;
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posInW_3.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - tmpvar_6);
  highp vec3 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.xz = tmpvar_10.xz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = (_miHoYo_WindParams1.x * _Gust);
  highp vec4 tmpvar_14;
  tmpvar_14 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_9 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.xyz = (tmpvar_5.xyz + ((
    ((normalize(tmpvar_4) * dot ((
      ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_12 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_8, tmpvar_4)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_9 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_3.y = (posInW_3.y + ((
    (dot (((
      (tmpvar_15 * tmpvar_15)
     * 
      (3.0 - (2.0 * tmpvar_15))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * (tmpvar_12 * (1.0 - abs(tmpvar_8.y))))
   * _BendIntensity) * _DownBendIntensity));
  posInW_3.xyz = (posInW_3.xyz + ((
    normalize(tmpvar_4)
   * tmpvar_13) * _BendIntensity));
  posInW_3.y = (posInW_3.y - ((
    (tmpvar_13 * dot (tmpvar_11, tmpvar_4))
   * 0.02) * _BendIntensity));
  highp vec3 tmpvar_16;
  tmpvar_16 = (posInW_3.xyz - tmpvar_6);
  posInW_3.xyz = (tmpvar_6 + ((tmpvar_16 * 
    sqrt(dot (tmpvar_10, tmpvar_10))
  ) / sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  tmpvar_1 = (unity_MatrixVP * posInW_3);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump vec3 _Color;
uniform mediump float _BloomFactor;
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
  col_1.xyz = (col_1.xyz * _Color);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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