//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMap" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYSingleLineTextureNoScaleOffset(_ShadowColor)] _LightMap ("Light Map |RGB (shadow color)", 2D) = "grey" { }
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_LightMapIntensity ("Light Map Intensity", Range(0, 5)) = 1
_FogTune ("Fog Tune", Range(0, 1)) = 1
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PASSFLAGS" = "OnlyDirectional" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 62310
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (tex_C_Color_4.xyz * ((2.0 * 
    (tex_S_Color_3.xyz * _ShadowColor)
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_7;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_8;
  srcColor_8 = colorBlendLightMap_2;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (srcColor_8, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = colorBlendLightMap_2;
  tmpvar_10.w = _BloomIntensity;
  tmpvar_1 = tmpvar_10;
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (tex_C_Color_4.xyz * ((2.0 * 
    (tex_S_Color_3.xyz * _ShadowColor)
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_7;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_8;
  srcColor_8 = colorBlendLightMap_2;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (srcColor_8, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = colorBlendLightMap_2;
  tmpvar_10.w = _BloomIntensity;
  tmpvar_1 = tmpvar_10;
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (tex_C_Color_4.xyz * ((2.0 * 
    (tex_S_Color_3.xyz * _ShadowColor)
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_7;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_8;
  srcColor_8 = colorBlendLightMap_2;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (srcColor_8, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = colorBlendLightMap_2;
  tmpvar_10.w = _BloomIntensity;
  tmpvar_1 = tmpvar_10;
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (tex_C_Color_4.xyz * ((2.0 * 
    (tex_S_Color_3.xyz * _ShadowColor)
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_7;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_8;
  srcColor_8 = colorBlendLightMap_2;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (srcColor_8, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = colorBlendLightMap_2;
  tmpvar_10.w = _BloomIntensity;
  tmpvar_1 = tmpvar_10;
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (tex_C_Color_4.xyz * ((2.0 * 
    (tex_S_Color_3.xyz * _ShadowColor)
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_7;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_8;
  srcColor_8 = colorBlendLightMap_2;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (srcColor_8, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = colorBlendLightMap_2;
  tmpvar_10.w = _BloomIntensity;
  tmpvar_1 = tmpvar_10;
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (tex_C_Color_4.xyz * ((2.0 * 
    (tex_S_Color_3.xyz * _ShadowColor)
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_7;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_8;
  srcColor_8 = colorBlendLightMap_2;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (srcColor_8, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = colorBlendLightMap_2;
  tmpvar_10.w = _BloomIntensity;
  tmpvar_1 = tmpvar_10;
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tex_C_Color_4.xyz * ((
    (2.0 * (tex_S_Color_3.xyz * _ShadowColor))
   * 
    (1.0 - (clamp ((tex_S_Color_3.w - _ShadowIntegration), 0.0, 1.0) * (1.0 - shadow_8)))
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_10;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_11;
  srcColor_11 = colorBlendLightMap_2;
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (srcColor_11, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_2;
  tmpvar_13.w = _BloomIntensity;
  tmpvar_1 = tmpvar_13;
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tex_C_Color_4.xyz * ((
    (2.0 * (tex_S_Color_3.xyz * _ShadowColor))
   * 
    (1.0 - (clamp ((tex_S_Color_3.w - _ShadowIntegration), 0.0, 1.0) * (1.0 - shadow_8)))
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_10;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_11;
  srcColor_11 = colorBlendLightMap_2;
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (srcColor_11, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_2;
  tmpvar_13.w = _BloomIntensity;
  tmpvar_1 = tmpvar_13;
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tex_C_Color_4.xyz * ((
    (2.0 * (tex_S_Color_3.xyz * _ShadowColor))
   * 
    (1.0 - (clamp ((tex_S_Color_3.w - _ShadowIntegration), 0.0, 1.0) * (1.0 - shadow_8)))
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_10;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_11;
  srcColor_11 = colorBlendLightMap_2;
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (srcColor_11, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_2;
  tmpvar_13.w = _BloomIntensity;
  tmpvar_1 = tmpvar_13;
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tex_C_Color_4.xyz * ((
    (2.0 * (tex_S_Color_3.xyz * _ShadowColor))
   * 
    (1.0 - (clamp ((tex_S_Color_3.w - _ShadowIntegration), 0.0, 1.0) * (1.0 - shadow_8)))
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_10;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_11;
  srcColor_11 = colorBlendLightMap_2;
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (srcColor_11, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_2;
  tmpvar_13.w = _BloomIntensity;
  tmpvar_1 = tmpvar_13;
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tex_C_Color_4.xyz * ((
    (2.0 * (tex_S_Color_3.xyz * _ShadowColor))
   * 
    (1.0 - (clamp ((tex_S_Color_3.w - _ShadowIntegration), 0.0, 1.0) * (1.0 - shadow_8)))
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_10;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_11;
  srcColor_11 = colorBlendLightMap_2;
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (srcColor_11, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_2;
  tmpvar_13.w = _BloomIntensity;
  tmpvar_1 = tmpvar_13;
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
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2 = _glesColor;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_9));
  highp float fogTune_10;
  fogTune_10 = _FogTune;
  mediump vec4 tmpvar_11;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    tmpvar_15 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_14))
       * 
        (_FogIntensity * tmpvar_14)
      ) * fogTune_10)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_14)) * (_FogColorIntensity * tmpvar_14))
    ), 0.0, 1.0)));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_11 = fogColor_12;
  } else {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_10)), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_19) / max (0.1, ((_FogEndDistance * fogTune_10) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_11 = fogColor_17;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_COLOR1 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform sampler2D _LightMap;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 tex_S_Color_3;
  mediump vec4 tex_C_Color_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightMap, xlv_TEXCOORD0.zw);
  tex_S_Color_3 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tex_C_Color_4.xyz * ((
    (2.0 * (tex_S_Color_3.xyz * _ShadowColor))
   * 
    (1.0 - (clamp ((tex_S_Color_3.w - _ShadowIntegration), 0.0, 1.0) * (1.0 - shadow_8)))
  ) + 1.0));
  colorBlendLightMap_2 = tmpvar_10;
  colorBlendLightMap_2 = (colorBlendLightMap_2 * _LightMapIntensity);
  mediump vec3 srcColor_11;
  srcColor_11 = colorBlendLightMap_2;
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (srcColor_11, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_2;
  tmpvar_13.w = _BloomIntensity;
  tmpvar_1 = tmpvar_13;
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
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}