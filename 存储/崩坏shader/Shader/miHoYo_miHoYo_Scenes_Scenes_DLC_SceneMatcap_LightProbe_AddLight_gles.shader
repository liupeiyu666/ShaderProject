//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/SceneMatcap_LightProbe_AddLight" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_FogTune ("Fog Tune", Range(0, 1)) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
[MHYHeaderBox(MATCAP)] _MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
[MHYHeaderBox(MATCAP SPECULAR)] [Toggle(_SEPARATE_SPECULAR_ON)] _EnableMatcapSpecular ("Enable Sperate Specular", Float) = 0
_SpecularMap ("Specular MatCap", 2D) = "black" { }
_SpecularIntensity ("Specular Intensity", Range(0, 1)) = 0
[MHYHeaderBox(ADDLIGHT)] _AdditiveLightPower ("Additive Light Power", Range(0.1, 5)) = 1
_AdditiveLightIntensity ("Additive Light Intensity", Range(0, 1)) = 1
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 50492
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD4, normals_7);
  worldNorm_5.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD5, normals_7);
  worldNorm_5.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD6, normals_7);
  worldNorm_5.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * worldNorm_5);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_18;
  mediump vec3 x_19;
  x_19.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_19.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_18 = (x_19 - unity_SHC.xyz);
  mediump vec3 tmpvar_20;
  tmpvar_20 = max (((1.055 * 
    pow (max (res_18, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_18 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (tmpvar_16, tmpvar_22)
   * tmpvar_16)));
  R_4 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((mix (tmpvar_16, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_25;
    highp vec2 P_26;
    P_26 = ((tmpvar_24 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_25 = texture2D (_SpecularMap, P_26);
    matcapSpecular_3 = (tmpvar_25 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MatCap, tmpvar_24);
  mc_2 = tmpvar_27;
  mc_2.xyz = ((mc_2.xyz * tmpvar_17) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_21) + matcapSpecular_3);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_17 * tmpvar_21) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_30;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 matcapMaskColor_6;
  mediump vec3 normals_7;
  mediump vec4 texColor_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_8 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_6 = tmpvar_13;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * worldNorm_5);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (texColor_8.xyz * _Color.xyz);
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_21.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_20 = (x_21 - unity_SHC.xyz);
  mediump vec3 tmpvar_22;
  tmpvar_22 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tmpvar_22 + _LightingColor) + _ShadowColor);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_24 - (2.0 * (
    dot (tmpvar_18, tmpvar_24)
   * tmpvar_18)));
  R_4 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((mix (tmpvar_18, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = ((tmpvar_26 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_27 = texture2D (_SpecularMap, P_28);
    matcapSpecular_3 = (tmpvar_27 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MatCap, tmpvar_26);
  mc_2 = tmpvar_29;
  mc_2.xyz = ((mc_2.xyz * tmpvar_19) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_23) + matcapSpecular_3);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((mc_2.xyz * matcapMaskColor_6.x) + ((tmpvar_19 * tmpvar_23) * (1.0 - matcapMaskColor_6.x)));
  finalColor_1 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = tmpvar_31;
  tmpvar_32.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_32;
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
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/AddLight/ADDLIGHT"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}