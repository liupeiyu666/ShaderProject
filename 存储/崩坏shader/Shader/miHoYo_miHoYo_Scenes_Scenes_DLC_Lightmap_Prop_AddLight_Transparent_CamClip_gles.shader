//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/Lightmap_Prop_AddLight_Transparent_CamClip" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_FogTune ("Fog Tune", Range(0, 1)) = 1
[MHYHeaderBox(MATCAP)] _MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
[MHYHeaderBox(MATCAP SPECULAR)] [Toggle(_SEPARATE_SPECULAR_ON)] _EnableMatcapSpecular ("Enable Sperate Specular", Float) = 0
_SpecularMap ("Specular MatCap", 2D) = "black" { }
_SpecularIntensity ("Specular Intensity", Range(0, 1)) = 0
[MHYHeaderBox(ADDLIGHT)] _AdditiveLightPower ("Additive Light Power", Range(0.1, 5)) = 1
_AdditiveLightIntensity ("Additive Light Intensity", Range(0, 1)) = 1
_Transparent ("_Trans", Float) = 1
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
}
SubShader {
 Tags { "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARDONLY"
  Tags { "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 20322
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
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * worldNorm_6);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_21;
  tmpvar_21 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23 - (2.0 * (
    dot (tmpvar_19, tmpvar_23)
   * tmpvar_19)));
  R_4 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((mix (tmpvar_19, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_26;
    highp vec2 P_27;
    P_27 = ((tmpvar_25 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_26 = texture2D (_SpecularMap, P_27);
    matcapSpecular_3 = (tmpvar_26 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MatCap, tmpvar_25);
  mc_2 = tmpvar_28;
  mc_2.xyz = ((mc_2.xyz * tmpvar_20) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) + matcapSpecular_3);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_20 * tmpvar_22) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  alpha_5 = tmpvar_31;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = tmpvar_31;
  gl_FragData[0] = tmpvar_33;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform mediump vec4 _ShadowTex_ST;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_5.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
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
  mediump float alpha_5;
  highp vec3 worldNorm_6;
  mediump vec4 texShadowColor_7;
  mediump vec4 matcapMaskColor_8;
  mediump vec3 normals_9;
  mediump vec4 texColor_10;
  highp vec2 vpos_11;
  vpos_11 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_11.y = ((fract(vpos_11.y) * 0.0625) + unity_LODFade.y);
  lowp float x_12;
  x_12 = (texture2D (_DitherMaskLOD2D, vpos_11).w - 0.5);
  if ((x_12 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_7 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.x = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD5, normals_9);
  worldNorm_6.y = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD6, normals_9);
  worldNorm_6.z = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_MatrixV[0].xyz;
  tmpvar_20[1] = unity_MatrixV[1].xyz;
  tmpvar_20[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * worldNorm_6);
  mediump vec3 tmpvar_22;
  tmpvar_22 = (texColor_10.xyz * _Color.xyz);
  highp float tmpvar_23;
  tmpvar_23 = (texColor_10.w * _Transparent);
  alpha_5 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((texShadowColor_7 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 - (2.0 * (
    dot (tmpvar_21, tmpvar_25)
   * tmpvar_21)));
  R_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((mix (tmpvar_21, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = ((tmpvar_27 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_28 = texture2D (_SpecularMap, P_29);
    matcapSpecular_3 = (tmpvar_28 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MatCap, tmpvar_27);
  mc_2 = tmpvar_30;
  mc_2.xyz = ((mc_2.xyz * tmpvar_22) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_24) + matcapSpecular_3);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((mc_2.xyz * matcapMaskColor_8.x) + ((tmpvar_22 * tmpvar_24) * (1.0 - matcapMaskColor_8.x)));
  finalColor_1 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp ((alpha_5 * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  alpha_5 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = tmpvar_32;
  tmpvar_35.w = tmpvar_33;
  gl_FragData[0] = tmpvar_35;
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
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}