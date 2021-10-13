//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMapUnity_Emission" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("RGB(Albedo) A(Emission)", 2D) = "white" { }
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
[MHYHeaderBox(Emission)] [Enum(UV1st,0,UV2nd,1)] _UseSet ("UV Set", Float) = 1
_Emission ("Emission Color", Color) = (0,0,0,0.5)
[MHYHeaderBox(ADDLIGHT)] _AdditiveLightPower ("Additive Light Power", Range(0.1, 5)) = 1
_AdditiveLightIntensity ("Additive Light Intensity", Range(0, 1)) = 1
_Transparent ("_Trans", Range(0, 1)) = 1
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 28387
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
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_18;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_19.w;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_20);
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_3;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_3;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_18;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_19.w;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_20);
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_3;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_3;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_18;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_19.w;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_20);
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_3;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_3;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_18;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_19.w;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_20);
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_3;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_3;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_18;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_19.w;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_20);
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_3;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_3;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_18;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_19.w;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_20);
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_3;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_3;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_17;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_18.w;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_19);
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_3;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_3;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_17;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_18.w;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_19);
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_3;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_3;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_17;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_18.w;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_19);
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_3;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_3;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_17;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_18.w;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_19);
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_3;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_3;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_17;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_18.w;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_19);
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_3;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_3;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_17;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_18.w;
  };
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_19);
  mediump vec3 srcColor_20;
  srcColor_20 = colorBlendLightMap_3;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (srcColor_20, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = colorBlendLightMap_3;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
  tmpvar_25.w = _BloomIntensity;
  tmpvar_1 = tmpvar_25;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_19;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_20.w;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_21);
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_3;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_3;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_19;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_20.w;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_21);
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_3;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_3;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_19;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_20.w;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_21);
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_3;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_3;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_19;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_20.w;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_21);
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_3;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_3;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_19;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_20.w;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_21);
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_3;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_3;
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
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_19;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_20.w;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_21);
  mediump vec3 srcColor_22;
  srcColor_22 = colorBlendLightMap_3;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (srcColor_22, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = colorBlendLightMap_3;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_21;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_22.w;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_3;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_3;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_21;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_22.w;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_3;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_3;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_21;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_22.w;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_3;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_3;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_21;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_22.w;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_3;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_3;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_21;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_22.w;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_3;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_3;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_21;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_22.w;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_3;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_3;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_20;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_21.w;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_22);
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_3;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = colorBlendLightMap_3;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_23;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_24.w;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_3;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_3;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_23;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_24.w;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_3;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_3;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_23;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_24.w;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_3;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_3;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_23;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_24.w;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_3;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_3;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_23;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_24.w;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_3;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_3;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_23;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_24.w;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_3;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_3;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_22;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_23.w;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_3;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_3;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_22;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_23.w;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_3;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_3;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_22;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_23.w;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_3;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_3;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_22;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_23.w;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_3;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_3;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_22;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_23.w;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_3;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_3;
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
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  highp vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  highp float THRESHOLDS_MATRIX_6[16];
  THRESHOLDS_MATRIX_6[0] = 0.05882353;
  THRESHOLDS_MATRIX_6[1] = 0.5294118;
  THRESHOLDS_MATRIX_6[2] = 0.1764706;
  THRESHOLDS_MATRIX_6[3] = 0.6470588;
  THRESHOLDS_MATRIX_6[4] = 0.7647059;
  THRESHOLDS_MATRIX_6[5] = 0.2941177;
  THRESHOLDS_MATRIX_6[6] = 0.8823529;
  THRESHOLDS_MATRIX_6[7] = 0.4117647;
  THRESHOLDS_MATRIX_6[8] = 0.2352941;
  THRESHOLDS_MATRIX_6[9] = 0.7058824;
  THRESHOLDS_MATRIX_6[10] = 0.1176471;
  THRESHOLDS_MATRIX_6[11] = 0.5882353;
  THRESHOLDS_MATRIX_6[12] = 0.9411765;
  THRESHOLDS_MATRIX_6[13] = 0.4705882;
  THRESHOLDS_MATRIX_6[14] = 0.8235294;
  THRESHOLDS_MATRIX_6[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_7.x / 4.0);
    highp float tmpvar_9;
    tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
    highp float tmpvar_10;
    if ((tmpvar_8 >= 0.0)) {
      tmpvar_10 = tmpvar_9;
    } else {
      tmpvar_10 = -(tmpvar_9);
    };
    highp float tmpvar_11;
    tmpvar_11 = (tmpvar_7.y / 4.0);
    highp float tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
    highp float tmpvar_13;
    if ((tmpvar_11 >= 0.0)) {
      tmpvar_13 = tmpvar_12;
    } else {
      tmpvar_13 = -(tmpvar_12);
    };
    highp float x_14;
    x_14 = (_Transparent - THRESHOLDS_MATRIX_6[int((
      (tmpvar_10 * 4.0)
     + tmpvar_13))]);
    if ((x_14 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_15;
  vpos_15 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_15.y = ((fract(vpos_15.y) * 0.0625) + unity_LODFade.y);
  lowp float x_16;
  x_16 = (texture2D (_DitherMaskLOD2D, vpos_15).w - 0.5);
  if ((x_16 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_22;
  emissionMask_2 = tex_C_Color_4.w;
  if (bool(_UseSet)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
    emissionMask_2 = tmpvar_23.w;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_3 = (colorBlendLightMap_3 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_3;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_3;
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
 UsePass "Hidden/miHoYo/DLC/Common/AddLight/ADDLIGHT"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}