//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMapUnityCubeReflect" {
Properties {
_RainMaskThreshold ("RainMaskThreshold", Range(0, 1)) = 1
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
_Color ("Color", Color) = (1,1,1,1)
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "white" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (0,0,0,0)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[MHYHeaderBox(Reflecting)] _ReflectionTex ("Reflection", 2D) = "black" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
_ReflectionEmissionAdjust ("Reflection Emission Adjust", Float) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_RainReflectivity ("Rain Reflectivity", Range(0, 5)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_LightMapIntensity ("Light Map Intensity", Range(0, 5)) = 1.5
_FogTune ("Fog Tune", Range(0, 1)) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PASSFLAGS" = "OnlyDirectional" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 2566
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_11;
  mediump float tmpvar_12;
  mediump vec3 N_13;
  N_13 = xlv_TEXCOORD6;
  tmpvar_12 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_13)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_14)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_15;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_16.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_12));
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_6;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_6;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_11;
  mediump float tmpvar_12;
  mediump vec3 N_13;
  N_13 = xlv_TEXCOORD6;
  tmpvar_12 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_13)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_14)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_15;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_16.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_12));
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_6;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_6;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_11;
  mediump float tmpvar_12;
  mediump vec3 N_13;
  N_13 = xlv_TEXCOORD6;
  tmpvar_12 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_13)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_14)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_15;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_16.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_12));
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_6;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_6;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_11;
  mediump float tmpvar_12;
  mediump vec3 N_13;
  N_13 = xlv_TEXCOORD6;
  tmpvar_12 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_13)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_14)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_15;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_16.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_12));
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_6;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_6;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_11;
  mediump float tmpvar_12;
  mediump vec3 N_13;
  N_13 = xlv_TEXCOORD6;
  tmpvar_12 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_13)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_14)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_15;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_16.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_12));
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_6;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_6;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_11;
  mediump float tmpvar_12;
  mediump vec3 N_13;
  N_13 = xlv_TEXCOORD6;
  tmpvar_12 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_13)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_14)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_15;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_16.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_12));
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_6;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = colorBlendLightMap_6;
  tmpvar_19.w = _BloomIntensity;
  tmpvar_1 = tmpvar_19;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_14;
  mediump float tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD6;
  tmpvar_15 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_17)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_18;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_19.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_15));
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_6;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_6;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_14;
  mediump float tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD6;
  tmpvar_15 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_17)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_18;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_19.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_15));
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_6;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_6;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_14;
  mediump float tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD6;
  tmpvar_15 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_17)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_18;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_19.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_15));
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_6;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_6;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_14;
  mediump float tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD6;
  tmpvar_15 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_17)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_18;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_19.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_15));
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_6;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_6;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_14;
  mediump float tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD6;
  tmpvar_15 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_17)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_18;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_19.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_15));
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_6;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_6;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_14;
  mediump float tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD6;
  tmpvar_15 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_17 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_17)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_18;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_19.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_15));
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_6;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_6;
  tmpvar_22.w = _BloomIntensity;
  tmpvar_1 = tmpvar_22;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_13;
  mediump float tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD6;
  tmpvar_14 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_15)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_16)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_17;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_18.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_14));
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_6;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_6;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_13;
  mediump float tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD6;
  tmpvar_14 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_15)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_16)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_17;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_18.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_14));
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_6;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_6;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_13;
  mediump float tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD6;
  tmpvar_14 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_15)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_16)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_17;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_18.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_14));
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_6;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_6;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_13;
  mediump float tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD6;
  tmpvar_14 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_15)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_16)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_17;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_18.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_14));
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_6;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_6;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_13;
  mediump float tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD6;
  tmpvar_14 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_15)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_16)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_17;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_18.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_14));
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_6;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_6;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (texture2D (unity_Lightmap, xlv_TEXCOORD0.zw).xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_13;
  mediump float tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD6;
  tmpvar_14 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_15)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_16)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_17;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_18.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_14));
  mediump vec3 srcColor_19;
  srcColor_19 = colorBlendLightMap_6;
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (srcColor_19, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = colorBlendLightMap_6;
  tmpvar_21.w = _BloomIntensity;
  tmpvar_1 = tmpvar_21;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump vec3 N_18;
  N_18 = xlv_TEXCOORD6;
  tmpvar_17 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_18)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_19)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_20;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_21.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_17));
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_6;
  tmpvar_24.w = _BloomIntensity;
  tmpvar_1 = tmpvar_24;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump vec3 N_18;
  N_18 = xlv_TEXCOORD6;
  tmpvar_17 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_18)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_19)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_20;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_21.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_17));
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_6;
  tmpvar_24.w = _BloomIntensity;
  tmpvar_1 = tmpvar_24;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump vec3 N_18;
  N_18 = xlv_TEXCOORD6;
  tmpvar_17 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_18)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_19)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_20;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_21.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_17));
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_6;
  tmpvar_24.w = _BloomIntensity;
  tmpvar_1 = tmpvar_24;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump vec3 N_18;
  N_18 = xlv_TEXCOORD6;
  tmpvar_17 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_18)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_19)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_20;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_21.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_17));
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_6;
  tmpvar_24.w = _BloomIntensity;
  tmpvar_1 = tmpvar_24;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump vec3 N_18;
  N_18 = xlv_TEXCOORD6;
  tmpvar_17 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_18)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_19)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_20;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_21.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_17));
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_6;
  tmpvar_24.w = _BloomIntensity;
  tmpvar_1 = tmpvar_24;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump vec3 N_18;
  N_18 = xlv_TEXCOORD6;
  tmpvar_17 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_18)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_19)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_20;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_21.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_17));
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_6;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_6;
  tmpvar_24.w = _BloomIntensity;
  tmpvar_1 = tmpvar_24;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_9;
  highp vec2 screenCoord_10;
  screenCoord_10 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_11;
  shadow_11 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_10);
    shadow_11 = tmpvar_12.x;
  };
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_11))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_15;
  mediump float tmpvar_16;
  mediump vec3 N_17;
  N_17 = xlv_TEXCOORD6;
  tmpvar_16 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_17)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_18)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_19;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_20.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_16));
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_6;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_6;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_9;
  highp vec2 screenCoord_10;
  screenCoord_10 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_11;
  shadow_11 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_10);
    shadow_11 = tmpvar_12.x;
  };
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_11))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_15;
  mediump float tmpvar_16;
  mediump vec3 N_17;
  N_17 = xlv_TEXCOORD6;
  tmpvar_16 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_17)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_18)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_19;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_20.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_16));
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_6;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_6;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_9;
  highp vec2 screenCoord_10;
  screenCoord_10 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_11;
  shadow_11 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_10);
    shadow_11 = tmpvar_12.x;
  };
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_11))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_15;
  mediump float tmpvar_16;
  mediump vec3 N_17;
  N_17 = xlv_TEXCOORD6;
  tmpvar_16 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_17)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_18)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_19;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_20.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_16));
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_6;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_6;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_9;
  highp vec2 screenCoord_10;
  screenCoord_10 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_11;
  shadow_11 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_10);
    shadow_11 = tmpvar_12.x;
  };
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_11))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_15;
  mediump float tmpvar_16;
  mediump vec3 N_17;
  N_17 = xlv_TEXCOORD6;
  tmpvar_16 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_17)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_18)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_19;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_20.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_16));
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_6;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_6;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_9;
  highp vec2 screenCoord_10;
  screenCoord_10 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_11;
  shadow_11 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_10);
    shadow_11 = tmpvar_12.x;
  };
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_11))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_15;
  mediump float tmpvar_16;
  mediump vec3 N_17;
  N_17 = xlv_TEXCOORD6;
  tmpvar_16 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_17)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_18)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_19;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_20.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_16));
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_6;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_6;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_9;
  highp vec2 screenCoord_10;
  screenCoord_10 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_11;
  shadow_11 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_10);
    shadow_11 = tmpvar_12.x;
  };
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_11))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_15;
  mediump float tmpvar_16;
  mediump vec3 N_17;
  N_17 = xlv_TEXCOORD6;
  tmpvar_16 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_17)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_18)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_19;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_20.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_16));
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_6;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_6;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_9;
  lowp vec4 color_10;
  color_10 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_10.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_10.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_10.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_10.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_10.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_10.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_10.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_10.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_10.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_10.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  highp vec2 vpos_8;
  vpos_8 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_8.y = ((fract(vpos_8.y) * 0.0625) + unity_LODFade.y);
  lowp float x_9;
  x_9 = (texture2D (_DitherMaskLOD2D, vpos_8).w - 0.5);
  if ((x_9 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_11;
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((tmpvar_10.xyz * _ShadowColor) * (1.0 - (clamp (
      (tmpvar_10.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_13))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD6;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_20)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_21;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_22.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_18));
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_6;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_6;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
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
  tmpvar_17 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD6;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_22)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_23;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_24.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_20));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_6;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_6;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
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
  tmpvar_17 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD6;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_22)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_23;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_24.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_20));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_6;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_6;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
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
  tmpvar_17 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD6;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_22)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_23;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_24.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_20));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_6;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_6;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
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
  tmpvar_17 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD6;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_22)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_23;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_24.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_20));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_6;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_6;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
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
  tmpvar_17 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD6;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_22)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_23;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_24.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_20));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_6;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_6;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
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
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_3 = _glesNormal;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_11));
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _FresnelParams;
uniform lowp samplerCube _EnvTex;
uniform mediump float _RainReflectivity;
uniform mediump float _RainMaskThreshold;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 reflColor_2;
  mediump vec3 R_3;
  mediump vec3 I_4;
  mediump vec4 reflectMask_5;
  highp vec3 colorBlendLightMap_6;
  mediump vec4 tex_C_Color_7;
  mediump vec4 lmtex_8;
  highp vec2 vpos_9;
  vpos_9 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_9.y = ((fract(vpos_9.y) * 0.0625) + unity_LODFade.y);
  lowp float x_10;
  x_10 = (texture2D (_DitherMaskLOD2D, vpos_9).w - 0.5);
  if ((x_10 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_8 = tmpvar_11;
  lowp vec4 color_12;
  color_12 = lmtex_8;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_7 = tmpvar_13;
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
  tmpvar_17 = ((tex_C_Color_7.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_15))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw);
  reflectMask_5 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz));
  I_4 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD6;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 - (2.0 * (
    dot (xlv_TEXCOORD6, tmpvar_22)
   * xlv_TEXCOORD6)));
  R_3 = tmpvar_23;
  if ((reflectMask_5.y < _RainMaskThreshold)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = textureCube (_EnvTex, R_3);
    reflColor_2 = ((tmpvar_24.xyz * _RainReflectivity) * reflectMask_5.x);
  } else {
    reflColor_2 = vec3(0.0, 0.0, 0.0);
  };
  colorBlendLightMap_6 = (colorBlendLightMap_6 + (reflColor_2 * tmpvar_20));
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_6;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_6;
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