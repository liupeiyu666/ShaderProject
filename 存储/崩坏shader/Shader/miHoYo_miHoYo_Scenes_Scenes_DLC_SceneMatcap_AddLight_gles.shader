//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/SceneMatcap_AddLight" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_FogTune ("Fog Tune", Range(0, 1)) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
[MHYHeaderBox(MATCAP)] _MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 52696
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_MatrixV[0].xyz;
  tmpvar_17[1] = unity_MatrixV[1].xyz;
  tmpvar_17[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_17 * worldNorm_5);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (worldNorm_5, tmpvar_18)
   * worldNorm_5)));
  R_4 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MatCap, tmpvar_21);
  mc_3 = tmpvar_22;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_8;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_8;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_COLOR1 = tmpvar_32;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  tmpvar_7 = (tmpvar_29 * _glesNormal);
  tmpvar_8 = (tmpvar_29 * ((unity_WorldToObject * _WorldSpaceLightPos0).xyz - (_glesVertex.xyz * _WorldSpaceLightPos0.w)));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = (tmpvar_29 * ((unity_WorldToObject * tmpvar_30).xyz - _glesVertex.xyz));
  highp vec3 lightColor0_31;
  lightColor0_31 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_32;
  lightColor1_32 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_33;
  lightColor2_33 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_34;
  lightColor3_34 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_35;
  lightAttenSq_35 = unity_4LightAtten0;
  highp vec3 normal_36;
  normal_36 = worldNormal_3;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * normal_36.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * normal_36.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * normal_36.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_35)
  ))));
  col_37 = (lightColor0_31 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_32 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_33 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_34 * tmpvar_45.w));
  highp float fogTune_46;
  fogTune_46 = _FogTune;
  mediump vec4 tmpvar_47;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_48;
    highp vec3 tmpvar_49;
    tmpvar_49 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_50;
    tmpvar_50 = max (0.0, (sqrt(
      dot (tmpvar_49, tmpvar_49)
    ) - _FogStartDistance));
    highp float tmpvar_51;
    tmpvar_51 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_50))
       * 
        (_FogIntensity * tmpvar_50)
      ) * fogTune_46)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_50)) * (_FogColorIntensity * tmpvar_50))
    ), 0.0, 1.0)));
    fogColor_48.xyz = tmpvar_52;
    fogColor_48.w = tmpvar_51;
    tmpvar_47 = fogColor_48;
  } else {
    mediump vec4 fogColor_53;
    highp vec3 tmpvar_54;
    tmpvar_54 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_55;
    tmpvar_55 = max (0.0, (sqrt(
      dot (tmpvar_54, tmpvar_54)
    ) - _FogStartDistance));
    highp float tmpvar_56;
    tmpvar_56 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_46)), _FogEffectLimit);
    highp vec3 tmpvar_57;
    tmpvar_57 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_55) / max (0.1, ((_FogEndDistance * fogTune_46) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_53.xyz = tmpvar_57;
    fogColor_53.w = tmpvar_56;
    tmpvar_47 = fogColor_53;
  };
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_21;
  xlv_TEXCOORD5 = tmpvar_22;
  xlv_TEXCOORD6 = tmpvar_23;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
  xlv_TEXCOORD9 = tmpvar_9;
  xlv_TEXCOORD10 = col_37;
  xlv_COLOR1 = tmpvar_47;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform mediump float _MetalRef;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD10;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 lightingColor_2;
  highp vec4 mc_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 MatcapMask_Color_6;
  mediump vec3 normals_7;
  highp vec3 colorBlendLightMap_8;
  mediump vec4 tex_C_Color_9;
  highp vec2 vpos_10;
  vpos_10 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_10.y = ((fract(vpos_10.y) * 0.0625) + unity_LODFade.y);
  lowp float x_11;
  x_11 = (texture2D (_DitherMaskLOD2D, vpos_10).w - 0.5);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_9 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_9.xyz * _Color.xyz) * (_ShadowColor + _LightingColor));
  colorBlendLightMap_8 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  MatcapMask_Color_6 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_MatrixV[0].xyz;
  tmpvar_19[1] = unity_MatrixV[1].xyz;
  tmpvar_19[2] = unity_MatrixV[2].xyz;
  worldNorm_5 = (tmpvar_19 * worldNorm_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (worldNorm_5, tmpvar_20)
   * worldNorm_5)));
  R_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (worldNorm_5, R_4, vec3(_MetalRef));
  worldNorm_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((tmpvar_22.xy * 0.5) + 0.5);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MatCap, tmpvar_23);
  mc_3 = tmpvar_24;
  mc_3 = ((mc_3 * tex_C_Color_9) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  lightingColor_2 = _LightingColor;
  lightingColor_2 = (lightingColor_2 + xlv_TEXCOORD10);
  mc_3.xyz = (mc_3.xyz * (_ShadowColor + lightingColor_2));
  colorBlendLightMap_8 = ((mc_3.xyz * MatcapMask_Color_6.x) + (colorBlendLightMap_8 * (1.0 - MatcapMask_Color_6.x)));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_8;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_8;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
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
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_SCENE_SHADOW_ON" }
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
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}