//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Terrain_AirEffect_LightMap (Reflecting Light)" {
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
_ReflectionTex ("Reflection", 2D) = "black" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
_ReflectionEmissionAdjust ("Reflection Emission Adjust", Float) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 5594
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  gl_FragData[0] = outColor_13;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
uniform mediump float _LumiFactor;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
uniform mediump float _LumiFactor;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
uniform mediump float _LumiFactor;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
uniform mediump float _LumiFactor;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
uniform mediump float _LumiFactor;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
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
uniform mediump float _LumiFactor;
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
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  outColor_13.xyz = mix (outColor_13.xyz, vec3(dot (outColor_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  outColor_13.xyz = mix (outColor_13.xyz, vec3(dot (outColor_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  outColor_13.xyz = mix (outColor_13.xyz, vec3(dot (outColor_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  outColor_13.xyz = mix (outColor_13.xyz, vec3(dot (outColor_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  outColor_13.xyz = mix (outColor_13.xyz, vec3(dot (outColor_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_22 = tmpvar_23.xyz;
  tmpvar_6 = tmpvar_22;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_1.zw;
  tmpvar_7 = o_24;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_10;
  xlv_TEXCOORD4 = normalize(normalize((_glesNormal * tmpvar_21)));
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - tmpvar_23.xyz));
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD2.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD2.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD3.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD3.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  outColor_13.xyz = colorBlendLightMap_4;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD6));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = outColor_13.xyz;
  tmpvar_28.w = _BloomFactor;
  outColor_13 = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  )));
  outColor_13.xyz = mix (outColor_13.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  outColor_13.xyz = mix (outColor_13.xyz, vec3(dot (outColor_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_13;
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
Fallback "Diffuse"
}