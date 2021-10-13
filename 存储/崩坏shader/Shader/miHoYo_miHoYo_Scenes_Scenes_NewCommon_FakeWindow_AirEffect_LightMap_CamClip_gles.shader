//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/FakeWindow_AirEffect_LightMap_CamClip" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_BackTex ("Back", 2D) = "white" { }
_BackDark ("Back Dark", Float) = 0.7
_BackDepthScale ("Back Depth Scale", Range(0, 1)) = 0
_MidTex ("Mid", 2D) = "white" { }
_MidDark ("Mid Dark", Float) = 0.3
_MidDepthScale ("Mid Depth Scale", Range(0, 1)) = 0.3
_FrontTex ("Front", 2D) = "white" { }
_MaskTex ("Mask", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_Specular ("Specular", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
  GpuProgramID 62454
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = xlv_TEXCOORD5;
  outColor_8.xyz = mix (outColor_8.xyz, vec3(dot (outColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = xlv_TEXCOORD5;
  outColor_8.xyz = mix (outColor_8.xyz, vec3(dot (outColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = xlv_TEXCOORD5;
  outColor_8.xyz = mix (outColor_8.xyz, vec3(dot (outColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = xlv_TEXCOORD5;
  outColor_8.xyz = mix (outColor_8.xyz, vec3(dot (outColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = xlv_TEXCOORD5;
  outColor_8.xyz = mix (outColor_8.xyz, vec3(dot (outColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump vec4 _FrontTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = 0.0;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_3 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.x;
  tmpvar_16.y = tmpvar_15.x;
  tmpvar_16.z = worldNormal_3.x;
  tmpvar_16.w = tmpvar_9.x;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.y;
  tmpvar_17.y = tmpvar_15.y;
  tmpvar_17.z = worldNormal_3.y;
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18.x = worldTangent_2.z;
  tmpvar_18.y = tmpvar_15.z;
  tmpvar_18.z = worldNormal_3.z;
  tmpvar_18.w = tmpvar_9.z;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_19;
  fogTune_19 = _FogTune;
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_23))
       * 
        (_FogIntensity * tmpvar_23)
      ) * fogTune_19)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_19)), _FogEffectLimit);
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, ((_FogEndDistance * fogTune_19) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_30;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  highp float fadeOffset_31;
  fadeOffset_31 = _FadeOffset;
  highp float fadeDistance_32;
  fadeDistance_32 = _FadeDistance;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_31) / fadeDistance_32), 0.0, 1.0);
  tmpvar_7 = tmpvar_33;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 worldNormal_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  mediump float wallMask_5;
  mediump vec3 viewDir_6;
  mediump vec3 worldViewDir_7;
  mediump vec4 outColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.w;
  tmpvar_9.y = xlv_TEXCOORD1.w;
  tmpvar_9.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
  worldViewDir_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((xlv_TEXCOORD0.xyz * worldViewDir_7.x) + (xlv_TEXCOORD1.xyz * worldViewDir_7.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_7.z));
  viewDir_6 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((-(viewDir_6.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_6.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_BackTex, tmpvar_12);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MidTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MaskTex, tmpvar_13).yyyy;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (mix ((tmpvar_14 * _BackDark), (tmpvar_15 * _MidDark), tmpvar_16).xyz, tmpvar_18.xyz, vec3(wallMask_5));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  tex_C_Color_4.w = tmpvar_20.w;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowTex, xlv_TEXCOORD4);
  tex_S_Color_3 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_7 - (2.0 * (
    dot (worldNormal_2, worldViewDir_7)
   * worldNormal_2)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_4.xyz = (tmpvar_19 + ((
    (1.0 - wallMask_5)
   * tmpvar_24.xyz) * _Reflectivity));
  colorBlendLightMap_1 = ((tex_C_Color_4.xyz * (
    (((2.0 * tex_S_Color_3.xyz) * tex_S_Color_3.w) + 1.0)
   - tex_S_Color_3.w)) * _LightMapIntensity);
  outColor_8.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_8.w = xlv_TEXCOORD5;
  outColor_8.xyz = mix (outColor_8.xyz, vec3(dot (outColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_8.w = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  gl_FragData[0] = outColor_8;
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
 Pass {
  Name "CONSTANT_REPLACE"
  LOD 200
  GpuProgramID 125222
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
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
}
}
}
Fallback "Diffuse"
}