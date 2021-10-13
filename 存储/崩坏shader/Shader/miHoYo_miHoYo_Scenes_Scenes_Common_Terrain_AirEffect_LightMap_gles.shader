//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Terrain_AirEffect_LightMap" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_Splat0Tex ("Splat0 Tex (RGB)", 2D) = "black" { }
_Splat1Tex ("Splat1 Tex (RGB)", 2D) = "black" { }
_Splat2Tex ("Splat2 Tex (RGB)", 2D) = "black" { }
_Splat3Tex ("Splat2 Tex (RGB)", 2D) = "black" { }
_ControlTex ("Control Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
[Toggle(USINGRIMGLOW)] _UsingRimGlow ("Using Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
_RGControlTexRRatio ("Rim Glow R Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexGRatio ("Rim Glow G Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexBRatio ("Rim Glow B Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexARatio ("Rim Glow A Channel Ratio Of Control Tex", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 56436
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  gl_FragData[0] = outColor_9;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  gl_FragData[0] = outColor_9;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  gl_FragData[0] = outColor_9;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  gl_FragData[0] = outColor_9;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  gl_FragData[0] = outColor_9;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  gl_FragData[0] = outColor_9;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_19)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_9.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_19;
  tmpvar_19 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_19;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
Fallback "Diffuse"
}