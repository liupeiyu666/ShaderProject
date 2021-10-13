//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMapUnityHLOD" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
_BaseColorIntensity ("BaseColorIntensity", Range(0, 3)) = 1
_BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PASSFLAGS" = "OnlyDirectional" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 61906
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_C_Color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_3.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_3;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  tmpvar_3 = _glesColor;
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
  tmpvar_4 = normalize((_glesNormal * tmpvar_10));
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
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _BaseColorIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tex_C_Color_1;
  highp vec2 vpos_2;
  vpos_2 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_2.y = ((fract(vpos_2.y) * 0.0625) + unity_LODFade.y);
  lowp float x_3;
  x_3 = (texture2D (_DitherMaskLOD2D, vpos_2).w - 0.5);
  if ((x_3 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = (tex_C_Color_1.xyz * _BaseColorIntensity);
  tmpvar_5.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_5;
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
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}