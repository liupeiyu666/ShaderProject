//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMapUnityCrystalsHouse" {
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
[MHYHeaderBox(BlackMask)] [MHYSingleLineTextureNoScaleOffset] _BlackMaskTex ("BlackMaskTex", 2D) = "white" { }
[MHYTextureScaleOffset] _BlackMaskTexTS ("BlackMaskTexTS", Vector) = (1,1,0,0)
_BlackMaskIntensity ("Mask Intensity", Range(0, 1)) = 0
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PASSFLAGS" = "OnlyDirectional" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 20779
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_13;
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_2;
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_2;
  tmpvar_16.w = _BloomIntensity;
  tmpvar_1 = tmpvar_16;
  gl_FragData[0] = tmpvar_1;
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_13;
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_2;
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_2;
  tmpvar_16.w = _BloomIntensity;
  tmpvar_1 = tmpvar_16;
  gl_FragData[0] = tmpvar_1;
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_13;
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_2;
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_2;
  tmpvar_16.w = _BloomIntensity;
  tmpvar_1 = tmpvar_16;
  gl_FragData[0] = tmpvar_1;
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_13;
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_2;
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_2;
  tmpvar_16.w = _BloomIntensity;
  tmpvar_1 = tmpvar_16;
  gl_FragData[0] = tmpvar_1;
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_13;
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_2;
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_2;
  tmpvar_16.w = _BloomIntensity;
  tmpvar_1 = tmpvar_16;
  gl_FragData[0] = tmpvar_1;
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_13;
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_2;
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_2;
  tmpvar_16.w = _BloomIntensity;
  tmpvar_1 = tmpvar_16;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_2;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = colorBlendLightMap_2;
  tmpvar_15.w = _BloomIntensity;
  tmpvar_1 = tmpvar_15;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_2;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = colorBlendLightMap_2;
  tmpvar_15.w = _BloomIntensity;
  tmpvar_1 = tmpvar_15;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_2;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = colorBlendLightMap_2;
  tmpvar_15.w = _BloomIntensity;
  tmpvar_1 = tmpvar_15;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_2;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = colorBlendLightMap_2;
  tmpvar_15.w = _BloomIntensity;
  tmpvar_1 = tmpvar_15;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_2;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = colorBlendLightMap_2;
  tmpvar_15.w = _BloomIntensity;
  tmpvar_1 = tmpvar_15;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_2;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = colorBlendLightMap_2;
  tmpvar_15.w = _BloomIntensity;
  tmpvar_1 = tmpvar_15;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = colorBlendLightMap_2;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = colorBlendLightMap_2;
  tmpvar_18.w = _BloomIntensity;
  tmpvar_1 = tmpvar_18;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = colorBlendLightMap_2;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = colorBlendLightMap_2;
  tmpvar_18.w = _BloomIntensity;
  tmpvar_1 = tmpvar_18;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = colorBlendLightMap_2;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = colorBlendLightMap_2;
  tmpvar_18.w = _BloomIntensity;
  tmpvar_1 = tmpvar_18;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = colorBlendLightMap_2;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = colorBlendLightMap_2;
  tmpvar_18.w = _BloomIntensity;
  tmpvar_1 = tmpvar_18;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = colorBlendLightMap_2;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = colorBlendLightMap_2;
  tmpvar_18.w = _BloomIntensity;
  tmpvar_1 = tmpvar_18;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = colorBlendLightMap_2;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = colorBlendLightMap_2;
  tmpvar_18.w = _BloomIntensity;
  tmpvar_1 = tmpvar_18;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_14;
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_2;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_2;
  tmpvar_17.w = _BloomIntensity;
  tmpvar_1 = tmpvar_17;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_14;
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_2;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_2;
  tmpvar_17.w = _BloomIntensity;
  tmpvar_1 = tmpvar_17;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_14;
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_2;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_2;
  tmpvar_17.w = _BloomIntensity;
  tmpvar_1 = tmpvar_17;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_14;
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_2;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_2;
  tmpvar_17.w = _BloomIntensity;
  tmpvar_1 = tmpvar_17;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_14;
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_2;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_2;
  tmpvar_17.w = _BloomIntensity;
  tmpvar_1 = tmpvar_17;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity)).xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_14;
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_2;
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_2;
  tmpvar_17.w = _BloomIntensity;
  tmpvar_1 = tmpvar_17;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_14;
  screenCoord_14 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_15;
  shadow_15 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_14);
    shadow_15 = tmpvar_16.x;
  };
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_13.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_2;
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = colorBlendLightMap_2;
  tmpvar_20.w = _BloomIntensity;
  tmpvar_1 = tmpvar_20;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_14;
  screenCoord_14 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_15;
  shadow_15 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_14);
    shadow_15 = tmpvar_16.x;
  };
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_13.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_2;
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = colorBlendLightMap_2;
  tmpvar_20.w = _BloomIntensity;
  tmpvar_1 = tmpvar_20;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_14;
  screenCoord_14 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_15;
  shadow_15 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_14);
    shadow_15 = tmpvar_16.x;
  };
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_13.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_2;
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = colorBlendLightMap_2;
  tmpvar_20.w = _BloomIntensity;
  tmpvar_1 = tmpvar_20;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_14;
  screenCoord_14 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_15;
  shadow_15 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_14);
    shadow_15 = tmpvar_16.x;
  };
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_13.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_2;
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = colorBlendLightMap_2;
  tmpvar_20.w = _BloomIntensity;
  tmpvar_1 = tmpvar_20;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_14;
  screenCoord_14 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_15;
  shadow_15 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_14);
    shadow_15 = tmpvar_16.x;
  };
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_13.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_2;
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = colorBlendLightMap_2;
  tmpvar_20.w = _BloomIntensity;
  tmpvar_1 = tmpvar_20;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_12.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (tex_C_ColorBegin_3, tmpvar_12, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_14;
  screenCoord_14 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_15;
  shadow_15 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_14);
    shadow_15 = tmpvar_16.x;
  };
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_13.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_2;
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = colorBlendLightMap_2;
  tmpvar_20.w = _BloomIntensity;
  tmpvar_1 = tmpvar_20;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_12.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_14))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_2;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_2;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_12.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_14))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_2;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_2;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_12.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_14))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_2;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_2;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_12.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_14))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_2;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_2;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_12.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_14))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_2;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_2;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_11.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (tex_C_ColorBegin_3, tmpvar_11, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_12.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_14))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_2;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_2;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_16;
  screenCoord_16 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_17;
  shadow_17 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_16);
    shadow_17 = tmpvar_18.x;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_15.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_17))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_19;
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_2;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_2;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_16;
  screenCoord_16 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_17;
  shadow_17 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_16);
    shadow_17 = tmpvar_18.x;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_15.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_17))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_19;
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_2;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_2;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_16;
  screenCoord_16 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_17;
  shadow_17 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_16);
    shadow_17 = tmpvar_18.x;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_15.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_17))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_19;
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_2;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_2;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_16;
  screenCoord_16 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_17;
  shadow_17 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_16);
    shadow_17 = tmpvar_18.x;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_15.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_17))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_19;
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_2;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_2;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_16;
  screenCoord_16 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_17;
  shadow_17 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_16);
    shadow_17 = tmpvar_18.x;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_15.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_17))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_19;
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_2;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_2;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_14.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_15;
  tmpvar_15 = mix (tex_C_ColorBegin_3, tmpvar_14, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_16;
  screenCoord_16 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_17;
  shadow_17 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_16);
    shadow_17 = tmpvar_18.x;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_15.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_17))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_19;
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_2;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_2;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_14;
  tmpvar_14 = mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_14.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_16))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_18;
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_2;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_2;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_14;
  tmpvar_14 = mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_14.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_16))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_18;
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_2;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_2;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_14;
  tmpvar_14 = mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_14.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_16))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_18;
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_2;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_2;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_14;
  tmpvar_14 = mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_14.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_16))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_18;
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_2;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_2;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_14;
  tmpvar_14 = mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_14.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_16))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_18;
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_2;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_2;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
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
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_4 = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_10));
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _BlackMaskTex;
uniform highp vec4 _BlackMaskTexTS;
uniform mediump float _BlackMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_C_ColorBegin_3;
  mediump vec4 BlackMask_4;
  mediump vec2 oo_5;
  mediump vec4 lmtex_6;
  highp vec2 vpos_7;
  vpos_7 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_7.y = ((fract(vpos_7.y) * 0.0625) + unity_LODFade.y);
  lowp float x_8;
  x_8 = (texture2D (_DitherMaskLOD2D, vpos_7).w - 0.5);
  if ((x_8 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD4 * _BlackMaskTexTS.xy) + _BlackMaskTexTS.zw);
  oo_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_BlackMaskTex, oo_5);
  BlackMask_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_ColorBegin_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = ((tex_C_ColorBegin_3.xyz * (1.0 - BlackMask_4.w)) + (BlackMask_4.xyz * BlackMask_4.w));
  tmpvar_13.w = tex_C_ColorBegin_3.w;
  mediump vec4 tmpvar_14;
  tmpvar_14 = mix (tex_C_ColorBegin_3, tmpvar_13, vec4(_BlackMaskIntensity));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_14.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_16))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_18;
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_2;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_2;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
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
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}