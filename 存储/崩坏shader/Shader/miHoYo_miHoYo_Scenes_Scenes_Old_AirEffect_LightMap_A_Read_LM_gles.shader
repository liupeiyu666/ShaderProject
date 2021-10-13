//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_LightMap_A_Read_LM" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
[Toggle(DEBUG_LIGHTMAP)] _DebugLightmap ("DebugLightmap", Float) = 0
_RGLightMap ("Rim Glow Ratio", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 16065
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
uniform mediump float _RGLightMap;
uniform mediump float _DebugLightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  highp vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  highp vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * ((2.0 * tmpvar_3.xyz) + 1.0));
  colorBlendLightMap_1 = tmpvar_4;
  if ((_DebugLightmap > 0.0)) {
    colorBlendLightMap_1 = ((tmpvar_4 * _RGLightMap) + (tmpvar_3.xyz * (1.0 - _RGLightMap)));
  } else {
    colorBlendLightMap_1 = ((colorBlendLightMap_1 * tmpvar_3.w) + (tmpvar_3.xyz * (1.0 - tmpvar_3.w)));
  };
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  outColor_2.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
uniform mediump float _RGLightMap;
uniform mediump float _DebugLightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  highp vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  highp vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * ((2.0 * tmpvar_3.xyz) + 1.0));
  colorBlendLightMap_1 = tmpvar_4;
  if ((_DebugLightmap > 0.0)) {
    colorBlendLightMap_1 = ((tmpvar_4 * _RGLightMap) + (tmpvar_3.xyz * (1.0 - _RGLightMap)));
  } else {
    colorBlendLightMap_1 = ((colorBlendLightMap_1 * tmpvar_3.w) + (tmpvar_3.xyz * (1.0 - tmpvar_3.w)));
  };
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  outColor_2.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
uniform mediump float _RGLightMap;
uniform mediump float _DebugLightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  highp vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  highp vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * ((2.0 * tmpvar_3.xyz) + 1.0));
  colorBlendLightMap_1 = tmpvar_4;
  if ((_DebugLightmap > 0.0)) {
    colorBlendLightMap_1 = ((tmpvar_4 * _RGLightMap) + (tmpvar_3.xyz * (1.0 - _RGLightMap)));
  } else {
    colorBlendLightMap_1 = ((colorBlendLightMap_1 * tmpvar_3.w) + (tmpvar_3.xyz * (1.0 - tmpvar_3.w)));
  };
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  outColor_2.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
uniform mediump float _RGLightMap;
uniform mediump float _DebugLightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  highp vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  highp vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * ((2.0 * tmpvar_3.xyz) + 1.0));
  colorBlendLightMap_1 = tmpvar_4;
  if ((_DebugLightmap > 0.0)) {
    colorBlendLightMap_1 = ((tmpvar_4 * _RGLightMap) + (tmpvar_3.xyz * (1.0 - _RGLightMap)));
  } else {
    colorBlendLightMap_1 = ((colorBlendLightMap_1 * tmpvar_3.w) + (tmpvar_3.xyz * (1.0 - tmpvar_3.w)));
  };
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  outColor_2.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
uniform mediump float _RGLightMap;
uniform mediump float _DebugLightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  highp vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  highp vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * ((2.0 * tmpvar_3.xyz) + 1.0));
  colorBlendLightMap_1 = tmpvar_4;
  if ((_DebugLightmap > 0.0)) {
    colorBlendLightMap_1 = ((tmpvar_4 * _RGLightMap) + (tmpvar_3.xyz * (1.0 - _RGLightMap)));
  } else {
    colorBlendLightMap_1 = ((colorBlendLightMap_1 * tmpvar_3.w) + (tmpvar_3.xyz * (1.0 - tmpvar_3.w)));
  };
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  outColor_2.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
uniform mediump float _RGLightMap;
uniform mediump float _DebugLightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  highp vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  highp vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * ((2.0 * tmpvar_3.xyz) + 1.0));
  colorBlendLightMap_1 = tmpvar_4;
  if ((_DebugLightmap > 0.0)) {
    colorBlendLightMap_1 = ((tmpvar_4 * _RGLightMap) + (tmpvar_3.xyz * (1.0 - _RGLightMap)));
  } else {
    colorBlendLightMap_1 = ((colorBlendLightMap_1 * tmpvar_3.w) + (tmpvar_3.xyz * (1.0 - tmpvar_3.w)));
  };
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  outColor_2.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    outColor_1.xyz = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    highp vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    outColor_1.xyz = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_8, fogParam_3.yyyy).xyz;
  };
  outColor_1.w = _BloomFactor;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    outColor_1.xyz = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    highp vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    outColor_1.xyz = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_8, fogParam_3.yyyy).xyz;
  };
  outColor_1.w = _BloomFactor;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    outColor_1.xyz = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    highp vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    outColor_1.xyz = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_8, fogParam_3.yyyy).xyz;
  };
  outColor_1.w = _BloomFactor;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    outColor_1.xyz = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    highp vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    outColor_1.xyz = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_8, fogParam_3.yyyy).xyz;
  };
  outColor_1.w = _BloomFactor;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    outColor_1.xyz = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    highp vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    outColor_1.xyz = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_8, fogParam_3.yyyy).xyz;
  };
  outColor_1.w = _BloomFactor;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_6;
  fogTune_6 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_10))
       * 
        (_FogIntensity * tmpvar_10)
      ) * fogTune_6)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
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
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_6)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, ((_FogEndDistance * fogTune_6) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_4 = tmpvar_7;
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    outColor_1.xyz = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    highp vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    outColor_1.xyz = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_8, fogParam_3.yyyy).xyz;
  };
  outColor_1.w = _BloomFactor;
  gl_FragData[0] = outColor_1;
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
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
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
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
}
}
}
Fallback "Diffuse"
}