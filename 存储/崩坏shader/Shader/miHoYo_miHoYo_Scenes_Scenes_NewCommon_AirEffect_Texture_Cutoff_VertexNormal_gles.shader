//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/AirEffect_Texture_Cutoff_VertexNormal" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_MainColor ("MainColor", Color) = (1,1,1,1)
_MainColorFar ("MainColorFar", Color) = (1,1,1,1)
_LightPosition ("LightPosition", Vector) = (1,1,1,1)
_LightIndensity ("LightIndensity", Range(0, 1)) = 0.5
_fresnelCol ("FresnelCol", Color) = (1,1,1,1)
_fresnelBase ("FresnelBase", Range(0, 1)) = 1
_fresnelScale ("FresnelScale", Range(0, 1)) = 1
_fresnelIndensity ("FresnelIndensity", Range(0, 5)) = 5
_FadeDistance ("Fade Color Start Distance", Range(0.1, 500)) = 0.5
_FadeOffset ("Fade Color Start Offset", Range(0, 500)) = 1
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 40095
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_NORMAL = tmpvar_2;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_21.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_19);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_21.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = mix (col_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_4.w = _BloomFactor;
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((xlv_NORMAL * tmpvar_8)));
  worldNormal_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_10;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_11;
  tmpvar_11 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_11;
  gl_FragData[0] = col_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_NORMAL = tmpvar_2;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_21.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_19);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_21.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = mix (col_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_4.w = _BloomFactor;
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((xlv_NORMAL * tmpvar_8)));
  worldNormal_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_10;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_11;
  tmpvar_11 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_11;
  gl_FragData[0] = col_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_NORMAL = tmpvar_2;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_21.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_19);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_21.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = mix (col_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_4.w = _BloomFactor;
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((xlv_NORMAL * tmpvar_8)));
  worldNormal_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_10;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_11;
  tmpvar_11 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_11;
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_NORMAL = tmpvar_2;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_21.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_19);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_21.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = mix (col_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_4.w = _BloomFactor;
  col_4.xyz = mix (col_4.xyz, vec3(dot (col_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((xlv_NORMAL * tmpvar_8)));
  worldNormal_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_10;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_11;
  tmpvar_11 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_11;
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_NORMAL = tmpvar_2;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_21.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_19);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_21.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = mix (col_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_4.w = _BloomFactor;
  col_4.xyz = mix (col_4.xyz, vec3(dot (col_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((xlv_NORMAL * tmpvar_8)));
  worldNormal_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_10;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_11;
  tmpvar_11 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_11;
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_NORMAL = tmpvar_2;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_21.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_19);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_21.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  col_4.xyz = mix (col_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_4.w = _BloomFactor;
  col_4.xyz = mix (col_4.xyz, vec3(dot (col_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((xlv_NORMAL * tmpvar_8)));
  worldNormal_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_10;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_11;
  tmpvar_11 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_11;
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  mediump vec3 fogParam_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_22;
  tmpvar_22 = max (0.0, (sqrt(
    dot (tmpvar_21, tmpvar_21)
  ) - _UWFogDistStart));
  highp float tmpvar_23;
  tmpvar_23 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_22)
    ) * (_UWFogDensity * tmpvar_22))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_24;
  tmpvar_24 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_22))
   * 
    (_UWFogColorNFIntensity * tmpvar_22)
  )), 0.0, 1.0);
  fogParam_19.x = tmpvar_24;
  fogParam_19.y = tmpvar_23;
  fogParam_19.z = tmpvar_20.y;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_26;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_19;
  xlv_NORMAL = tmpvar_2;
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_20.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_25);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_20.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD1;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = col_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    col_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = col_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    col_4.xyz = tmpvar_16;
  };
  col_4.w = _BloomFactor;
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(normalize((xlv_NORMAL * tmpvar_18)));
  worldNormal_2 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_20;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_21;
  tmpvar_21 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_21;
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  mediump vec3 fogParam_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_22;
  tmpvar_22 = max (0.0, (sqrt(
    dot (tmpvar_21, tmpvar_21)
  ) - _UWFogDistStart));
  highp float tmpvar_23;
  tmpvar_23 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_22)
    ) * (_UWFogDensity * tmpvar_22))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_24;
  tmpvar_24 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_22))
   * 
    (_UWFogColorNFIntensity * tmpvar_22)
  )), 0.0, 1.0);
  fogParam_19.x = tmpvar_24;
  fogParam_19.y = tmpvar_23;
  fogParam_19.z = tmpvar_20.y;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_26;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_19;
  xlv_NORMAL = tmpvar_2;
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_20.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_25);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_20.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD1;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = col_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    col_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = col_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    col_4.xyz = tmpvar_16;
  };
  col_4.w = _BloomFactor;
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(normalize((xlv_NORMAL * tmpvar_18)));
  worldNormal_2 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_20;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_21;
  tmpvar_21 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_21;
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  mediump vec3 fogParam_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_22;
  tmpvar_22 = max (0.0, (sqrt(
    dot (tmpvar_21, tmpvar_21)
  ) - _UWFogDistStart));
  highp float tmpvar_23;
  tmpvar_23 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_22)
    ) * (_UWFogDensity * tmpvar_22))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_24;
  tmpvar_24 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_22))
   * 
    (_UWFogColorNFIntensity * tmpvar_22)
  )), 0.0, 1.0);
  fogParam_19.x = tmpvar_24;
  fogParam_19.y = tmpvar_23;
  fogParam_19.z = tmpvar_20.y;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_26;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_19;
  xlv_NORMAL = tmpvar_2;
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_20.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_25);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_20.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD1;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = col_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    col_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = col_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    col_4.xyz = tmpvar_16;
  };
  col_4.w = _BloomFactor;
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(normalize((xlv_NORMAL * tmpvar_18)));
  worldNormal_2 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_20;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_21;
  tmpvar_21 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_21;
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  mediump vec3 fogParam_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_22;
  tmpvar_22 = max (0.0, (sqrt(
    dot (tmpvar_21, tmpvar_21)
  ) - _UWFogDistStart));
  highp float tmpvar_23;
  tmpvar_23 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_22)
    ) * (_UWFogDensity * tmpvar_22))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_24;
  tmpvar_24 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_22))
   * 
    (_UWFogColorNFIntensity * tmpvar_22)
  )), 0.0, 1.0);
  fogParam_19.x = tmpvar_24;
  fogParam_19.y = tmpvar_23;
  fogParam_19.z = tmpvar_20.y;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_26;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_19;
  xlv_NORMAL = tmpvar_2;
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_20.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_25);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_20.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD1;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = col_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    col_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = col_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    col_4.xyz = tmpvar_16;
  };
  col_4.w = _BloomFactor;
  col_4.xyz = mix (col_4.xyz, vec3(dot (col_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(normalize((xlv_NORMAL * tmpvar_18)));
  worldNormal_2 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_20;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_21;
  tmpvar_21 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_21;
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  mediump vec3 fogParam_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_22;
  tmpvar_22 = max (0.0, (sqrt(
    dot (tmpvar_21, tmpvar_21)
  ) - _UWFogDistStart));
  highp float tmpvar_23;
  tmpvar_23 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_22)
    ) * (_UWFogDensity * tmpvar_22))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_24;
  tmpvar_24 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_22))
   * 
    (_UWFogColorNFIntensity * tmpvar_22)
  )), 0.0, 1.0);
  fogParam_19.x = tmpvar_24;
  fogParam_19.y = tmpvar_23;
  fogParam_19.z = tmpvar_20.y;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_26;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_19;
  xlv_NORMAL = tmpvar_2;
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_20.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_25);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_20.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD1;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = col_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    col_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = col_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    col_4.xyz = tmpvar_16;
  };
  col_4.w = _BloomFactor;
  col_4.xyz = mix (col_4.xyz, vec3(dot (col_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(normalize((xlv_NORMAL * tmpvar_18)));
  worldNormal_2 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_20;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_21;
  tmpvar_21 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_21;
  gl_FragData[0] = col_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_1 = _glesColor;
  tmpvar_2 = _glesNormal;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  mediump vec3 fogParam_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_22;
  tmpvar_22 = max (0.0, (sqrt(
    dot (tmpvar_21, tmpvar_21)
  ) - _UWFogDistStart));
  highp float tmpvar_23;
  tmpvar_23 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_22)
    ) * (_UWFogDensity * tmpvar_22))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_24;
  tmpvar_24 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_22))
   * 
    (_UWFogColorNFIntensity * tmpvar_22)
  )), 0.0, 1.0);
  fogParam_19.x = tmpvar_24;
  fogParam_19.y = tmpvar_23;
  fogParam_19.z = tmpvar_20.y;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_5 = tmpvar_26;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_1.xyz;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_19;
  xlv_NORMAL = tmpvar_2;
  xlv_TEXCOORD2 = (_WorldSpaceLightPos0.xyz - (tmpvar_20.xyz * _WorldSpaceLightPos0.w));
  xlv_TEXCOORD3 = (_glesNormal * tmpvar_25);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_20.xyz);
  xlv_TEXCOORD5 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp vec4 _MainColor;
uniform highp vec4 _MainColorFar;
uniform highp vec3 _LightPosition;
uniform mediump float _LightIndensity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 shadowColor_1;
  mediump vec3 worldNormal_2;
  mediump vec3 maincolor_3;
  mediump vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_4 = tmpvar_5;
  mediump float x_6;
  x_6 = (col_4.w - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_4.xyz = (col_4.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD1;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = col_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    col_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = col_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    col_4.xyz = tmpvar_16;
  };
  col_4.w = _BloomFactor;
  col_4.xyz = mix (col_4.xyz, vec3(dot (col_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_MainColor, _MainColorFar, vec4(xlv_TEXCOORD5)).xyz;
  maincolor_3 = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(normalize((xlv_NORMAL * tmpvar_18)));
  worldNormal_2 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = ((_LightIndensity * max (0.0, 
    ((dot (worldNormal_2, _LightPosition) * 0.5) + 1.0)
  )) + maincolor_3);
  shadowColor_1 = tmpvar_20;
  col_4.xyz = (col_4.xyz * shadowColor_1);
  highp vec3 tmpvar_21;
  tmpvar_21 = clamp ((col_4.xyz + (
    (_fresnelBase + (_fresnelScale * pow ((1.0 - 
      dot (normalize(xlv_TEXCOORD3), normalize(xlv_TEXCOORD4))
    ), _fresnelIndensity)))
   * _fresnelCol).xyz), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  col_4.xyz = tmpvar_21;
  gl_FragData[0] = col_4;
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
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
}
}
}
}