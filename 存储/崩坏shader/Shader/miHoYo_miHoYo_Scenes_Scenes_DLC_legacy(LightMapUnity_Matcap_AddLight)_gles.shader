//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/legacy(LightMapUnity_Matcap_AddLight)" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (0,0,0,0)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_LightMapIntensity ("Light Map Intensity", Range(0, 5)) = 1.5
_FogTune ("Fog Tune", Range(0, 1)) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
[MHYHeaderBox(MATCAP)] _MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
[MHYHeaderBox(LIGHTMAP)] [Toggle(_LIGHTMAPCOLOR_ON)] _EnableLightmapColor ("Enable LightmapColor Change", Float) = 0
_LightmapColorScale ("LightmapColorScale", Range(0, 4)) = 1.85
_LightmapColorIns ("LightmapColorIns", Range(0, 2)) = 0.9
_LightmapColorChange ("LightmapColorChange (RGB)", 2D) = "white" { }
_LightmapColorLerp ("LightmapColorLerp", Range(0, 1)) = 1
[MHYHeaderBox(ADDLIGHT)] _AdditiveLightPower ("Additive Light Power", Range(0.1, 5)) = 1
_AdditiveLightIntensity ("Additive Light Intensity", Range(0, 1)) = 1
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 7776
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
attribute vec4 _glesColor;
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
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_5 = _glesColor;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.x;
  tmpvar_18.y = worldBinormal_1.x;
  tmpvar_18.z = worldNormal_3.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.y;
  tmpvar_19.y = worldBinormal_1.y;
  tmpvar_19.z = worldNormal_3.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_2.z;
  tmpvar_20.y = worldBinormal_1.z;
  tmpvar_20.z = worldNormal_3.z;
  highp float fogTune_21;
  fogTune_21 = _FogTune;
  mediump vec4 tmpvar_22;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_25))
       * 
        (_FogIntensity * tmpvar_25)
      ) * fogTune_21)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_25)) * (_FogColorIntensity * tmpvar_25))
    ), 0.0, 1.0)));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_22 = fogColor_23;
  } else {
    mediump vec4 fogColor_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, (sqrt(
      dot (tmpvar_29, tmpvar_29)
    ) - _FogStartDistance));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_21)), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_30) / max (0.1, ((_FogEndDistance * fogTune_21) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_28.xyz = tmpvar_32;
    fogColor_28.w = tmpvar_31;
    tmpvar_22 = fogColor_28;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_20;
  xlv_COLOR1 = tmpvar_22;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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