//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Sakura Tree Trunk Wind" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_LightMapIntensity ("Light Map Intensity", Float) = 1
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_WindDirection ("Wind Direction", Vector) = (1,0,0,0)
_BendIntensity ("Bend Intensity", Range(0, 1)) = 0.5
_BendSpeed ("Bend Speed", Range(0, 10)) = 0
_SideBendIntensity ("Side Bend Intensity", Range(0, 1)) = 0
_SideBendVariance ("Bend Variance", Float) = 1
_SideBendSoftness ("Side Bend Softness", Range(0, 10)) = 6
_DownBendIntensity ("Down Bend Intensity", Range(0, 1)) = 0
_DownBendVariance ("Down Bend Variance", Float) = 1
_DownBendSoftness ("Down Bend Softness", Range(0, 10)) = 6
_Gust ("Gust", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 10548
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  gl_FragData[0] = col_3;
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
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  gl_FragData[0] = col_3;
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
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  gl_FragData[0] = col_3;
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
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  gl_FragData[0] = col_3;
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
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  gl_FragData[0] = col_3;
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
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  gl_FragData[0] = col_3;
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
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  col_3.xyz = mix (col_3.xyz, vec3(dot (col_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_3;
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
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  col_3.xyz = mix (col_3.xyz, vec3(dot (col_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_3;
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
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  col_3.xyz = mix (col_3.xyz, vec3(dot (col_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_3;
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
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  col_3.xyz = mix (col_3.xyz, vec3(dot (col_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_3;
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
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  col_3.xyz = mix (col_3.xyz, vec3(dot (col_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_3;
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
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _SideBendVariance;
uniform highp float _SideBendIntensity;
uniform highp float _SideBendSoftness;
uniform highp float _DownBendIntensity;
uniform highp float _DownBendVariance;
uniform highp float _DownBendSoftness;
uniform highp float _Gust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 posInW_5;
  highp vec3 tmpvar_6;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_6 = _miHoYo_Wind.xyz;
  } else {
    tmpvar_6 = _WindDirection;
  };
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  posInW_5.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, vec3(1.0, 1.0, 1.0));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - tmpvar_8);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.xz = tmpvar_12.xz;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract((((
        ((_miHoYo_Wind.w * _miHoYo_WindParams1.z) + _miHoYo_WindParams1.w)
       * _BendSpeed) + (tmpvar_11 * _SideBendVariance)) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.xyz = (tmpvar_7.xyz + ((
    ((normalize(tmpvar_6) * dot ((
      ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)))
     - 0.5), vec4(1.0, 1.0, 1.0, 1.0))) * (pow ((tmpvar_14 * 0.3), _SideBendSoftness) * (1.0 - abs(
      dot (tmpvar_10, tmpvar_6)
    ))))
   * _BendIntensity) * _SideBendIntensity));
  highp vec4 tmpvar_16;
  tmpvar_16 = abs(((
    fract((((
      fract((((
        (_Time.y * _BendSpeed)
       + 
        (tmpvar_11 * _DownBendVariance)
      ) - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_5.y = (posInW_5.y + ((
    (dot (((
      (tmpvar_16 * tmpvar_16)
     * 
      (3.0 - (2.0 * tmpvar_16))
    ) - 0.5), vec4(1.0, 1.0, 1.0, 1.0)) * ((pow (
      (tmpvar_14 * 0.1)
    , _DownBendSoftness) * (1.0 - 
      abs(tmpvar_10.y)
    )) * 5.0))
   * _BendIntensity) * _DownBendIntensity));
  posInW_5.xyz = (posInW_5.xyz + ((
    (normalize(tmpvar_6) * (_miHoYo_WindParams1.x * _Gust))
   * _BendIntensity) * tmpvar_14));
  highp vec3 tmpvar_17;
  tmpvar_17 = (posInW_5.xyz - tmpvar_8);
  posInW_5.xyz = (tmpvar_8 + ((tmpvar_17 * 
    sqrt(dot (tmpvar_12, tmpvar_12))
  ) / sqrt(
    dot (tmpvar_17, tmpvar_17)
  )));
  tmpvar_2 = (unity_MatrixVP * posInW_5);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _LightMapIntensity;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 col_3;
  col_3.w = 0.0;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_1 = tmpvar_5;
  col_3.xyz = ((2.0 * tex_C_Color_2.xyz) * (tex_S_Color_1.xyz * _LightMapIntensity));
  col_3.xyz = mix (col_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_3.w = _BloomFactor;
  col_3.xyz = mix (col_3.xyz, vec3(dot (col_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_3;
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