//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMapUnity_Emission_Legacy" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("RGB(Albedo)", 2D) = "white" { }
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
[MHYHeaderBox(Emission)] _EmissionMask ("Emission Mask", 2D) = "black" { }
[Enum(R,0,G,1,B,2)] _UseChannel ("Use Channel", Float) = 1
[Enum(UV1st,0,UV2nd,1)] _UseSet ("UV Set", Float) = 1
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
  GpuProgramID 8721
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.zw = vec2(0.0, 0.0);
  tmpvar_20.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (tmpvar_20, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21.xy).xyz;
  emissionTex_3 = tmpvar_22;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_23;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_4;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_4;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.zw = vec2(0.0, 0.0);
  tmpvar_20.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (tmpvar_20, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21.xy).xyz;
  emissionTex_3 = tmpvar_22;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_23;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_4;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_4;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.zw = vec2(0.0, 0.0);
  tmpvar_20.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (tmpvar_20, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21.xy).xyz;
  emissionTex_3 = tmpvar_22;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_23;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_4;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_4;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.zw = vec2(0.0, 0.0);
  tmpvar_20.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (tmpvar_20, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21.xy).xyz;
  emissionTex_3 = tmpvar_22;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_23;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_4;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_4;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.zw = vec2(0.0, 0.0);
  tmpvar_20.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (tmpvar_20, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21.xy).xyz;
  emissionTex_3 = tmpvar_22;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_23;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_4;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_4;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.zw = vec2(0.0, 0.0);
  tmpvar_20.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (tmpvar_20, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21.xy).xyz;
  emissionTex_3 = tmpvar_22;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_23;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_24);
  mediump vec3 srcColor_25;
  srcColor_25 = colorBlendLightMap_4;
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (srcColor_25, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = colorBlendLightMap_4;
  tmpvar_27.w = _BloomIntensity;
  tmpvar_1 = tmpvar_27;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 0.0);
  tmpvar_19.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (tmpvar_19, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20.xy).xyz;
  emissionTex_3 = tmpvar_21;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_22;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_4;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_4;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 0.0);
  tmpvar_19.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (tmpvar_19, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20.xy).xyz;
  emissionTex_3 = tmpvar_21;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_22;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_4;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_4;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 0.0);
  tmpvar_19.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (tmpvar_19, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20.xy).xyz;
  emissionTex_3 = tmpvar_21;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_22;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_4;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_4;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 0.0);
  tmpvar_19.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (tmpvar_19, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20.xy).xyz;
  emissionTex_3 = tmpvar_21;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_22;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_4;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_4;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 0.0);
  tmpvar_19.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (tmpvar_19, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20.xy).xyz;
  emissionTex_3 = tmpvar_21;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_22;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_4;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_4;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 0.0);
  tmpvar_19.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (tmpvar_19, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20.xy).xyz;
  emissionTex_3 = tmpvar_21;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_22;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_23);
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_4;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = colorBlendLightMap_4;
  tmpvar_26.w = _BloomIntensity;
  tmpvar_1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.zw = vec2(0.0, 0.0);
  tmpvar_21.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22.xy).xyz;
  emissionTex_3 = tmpvar_23;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_24;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_4;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_4;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.zw = vec2(0.0, 0.0);
  tmpvar_21.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22.xy).xyz;
  emissionTex_3 = tmpvar_23;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_24;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_4;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_4;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.zw = vec2(0.0, 0.0);
  tmpvar_21.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22.xy).xyz;
  emissionTex_3 = tmpvar_23;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_24;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_4;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_4;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.zw = vec2(0.0, 0.0);
  tmpvar_21.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22.xy).xyz;
  emissionTex_3 = tmpvar_23;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_24;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_4;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_4;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.zw = vec2(0.0, 0.0);
  tmpvar_21.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22.xy).xyz;
  emissionTex_3 = tmpvar_23;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_24;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_4;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_4;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    (lmtex_6.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.zw = vec2(0.0, 0.0);
  tmpvar_21.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22.xy).xyz;
  emissionTex_3 = tmpvar_23;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_24;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_25);
  mediump vec3 srcColor_26;
  srcColor_26 = colorBlendLightMap_4;
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (srcColor_26, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = colorBlendLightMap_4;
  tmpvar_28.w = _BloomIntensity;
  tmpvar_1 = tmpvar_28;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
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
  tmpvar_22 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (tmpvar_23, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24.xy).xyz;
  emissionTex_3 = tmpvar_25;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_26;
  };
  mediump vec3 tmpvar_27;
  tmpvar_27 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_27);
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_4;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_4;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
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
  tmpvar_22 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (tmpvar_23, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24.xy).xyz;
  emissionTex_3 = tmpvar_25;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_26;
  };
  mediump vec3 tmpvar_27;
  tmpvar_27 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_27);
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_4;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_4;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
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
  tmpvar_22 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (tmpvar_23, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24.xy).xyz;
  emissionTex_3 = tmpvar_25;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_26;
  };
  mediump vec3 tmpvar_27;
  tmpvar_27 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_27);
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_4;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_4;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
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
  tmpvar_22 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (tmpvar_23, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24.xy).xyz;
  emissionTex_3 = tmpvar_25;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_26;
  };
  mediump vec3 tmpvar_27;
  tmpvar_27 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_27);
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_4;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_4;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
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
  tmpvar_22 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (tmpvar_23, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24.xy).xyz;
  emissionTex_3 = tmpvar_25;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_26;
  };
  mediump vec3 tmpvar_27;
  tmpvar_27 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_27);
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_4;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_4;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_16.w;
  lowp vec4 color_17;
  color_17 = tmpvar_16;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_17.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_18;
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
  tmpvar_22 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (tmpvar_23, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24.xy).xyz;
  emissionTex_3 = tmpvar_25;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_26;
  };
  mediump vec3 tmpvar_27;
  tmpvar_27 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_27);
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_4;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_4;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
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
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
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
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
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
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
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
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
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
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_17;
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
  tmpvar_21 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_19))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23.xy).xyz;
  emissionTex_3 = tmpvar_24;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_25;
  };
  mediump vec3 tmpvar_26;
  tmpvar_26 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_26);
  mediump vec3 srcColor_27;
  srcColor_27 = colorBlendLightMap_4;
  mediump vec3 tmpvar_28;
  tmpvar_28 = mix (srcColor_27, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = colorBlendLightMap_4;
  tmpvar_29.w = _BloomIntensity;
  tmpvar_1 = tmpvar_29;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26.xy).xyz;
  emissionTex_3 = tmpvar_27;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_28;
  };
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_29);
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_4;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_4;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26.xy).xyz;
  emissionTex_3 = tmpvar_27;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_28;
  };
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_29);
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_4;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_4;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26.xy).xyz;
  emissionTex_3 = tmpvar_27;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_28;
  };
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_29);
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_4;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_4;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26.xy).xyz;
  emissionTex_3 = tmpvar_27;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_28;
  };
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_29);
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_4;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_4;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26.xy).xyz;
  emissionTex_3 = tmpvar_27;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_28;
  };
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_29);
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_4;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_4;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_6.w = tmpvar_18.w;
  lowp vec4 color_19;
  color_19 = tmpvar_18;
  lmtex_6.xyz = (unity_Lightmap_HDR.x * color_19.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26.xy).xyz;
  emissionTex_3 = tmpvar_27;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_28;
  };
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_29);
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_4;
  mediump vec3 tmpvar_31;
  tmpvar_31 = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_4;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
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
  tmpvar_23 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (tmpvar_24, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25.xy).xyz;
  emissionTex_3 = tmpvar_26;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  tmpvar_28 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_28);
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_4;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_4;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
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
  tmpvar_23 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (tmpvar_24, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25.xy).xyz;
  emissionTex_3 = tmpvar_26;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  tmpvar_28 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_28);
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_4;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_4;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
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
  tmpvar_23 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (tmpvar_24, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25.xy).xyz;
  emissionTex_3 = tmpvar_26;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  tmpvar_28 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_28);
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_4;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_4;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
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
  tmpvar_23 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (tmpvar_24, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25.xy).xyz;
  emissionTex_3 = tmpvar_26;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  tmpvar_28 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_28);
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_4;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_4;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
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
  tmpvar_23 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (tmpvar_24, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25.xy).xyz;
  emissionTex_3 = tmpvar_26;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  tmpvar_28 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_28);
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_4;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_4;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec3 emissionTex_3;
  highp vec3 colorBlendLightMap_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 lmtex_6;
  highp float THRESHOLDS_MATRIX_7[16];
  THRESHOLDS_MATRIX_7[0] = 0.05882353;
  THRESHOLDS_MATRIX_7[1] = 0.5294118;
  THRESHOLDS_MATRIX_7[2] = 0.1764706;
  THRESHOLDS_MATRIX_7[3] = 0.6470588;
  THRESHOLDS_MATRIX_7[4] = 0.7647059;
  THRESHOLDS_MATRIX_7[5] = 0.2941177;
  THRESHOLDS_MATRIX_7[6] = 0.8823529;
  THRESHOLDS_MATRIX_7[7] = 0.4117647;
  THRESHOLDS_MATRIX_7[8] = 0.2352941;
  THRESHOLDS_MATRIX_7[9] = 0.7058824;
  THRESHOLDS_MATRIX_7[10] = 0.1176471;
  THRESHOLDS_MATRIX_7[11] = 0.5882353;
  THRESHOLDS_MATRIX_7[12] = 0.9411765;
  THRESHOLDS_MATRIX_7[13] = 0.4705882;
  THRESHOLDS_MATRIX_7[14] = 0.8235294;
  THRESHOLDS_MATRIX_7[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_8;
    tmpvar_8 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_8.y / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float x_15;
    x_15 = (_Transparent - THRESHOLDS_MATRIX_7[int((
      (tmpvar_11 * 4.0)
     + tmpvar_14))]);
    if ((x_15 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_16;
  vpos_16 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_16.y = ((fract(vpos_16.y) * 0.0625) + unity_LODFade.y);
  lowp float x_17;
  x_17 = (texture2D (_DitherMaskLOD2D, vpos_16).w - 0.5);
  if ((x_17 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_5 = tmpvar_19;
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
  tmpvar_23 = ((tex_C_Color_5.xyz * _Color.xyz) * ((
    ((lmtex_6.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_6.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (tmpvar_24, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25.xy).xyz;
  emissionTex_3 = tmpvar_26;
  emissionMask_2 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_2 = emissionTex_3.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_3.x, emissionTex_3.y, float(_UseChannel));
    emissionMask_2 = tmpvar_27;
  };
  mediump vec3 tmpvar_28;
  tmpvar_28 = ((emissionMask_2 * _Emission.xyz) * (_Emission.w * 2.0));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + tmpvar_28);
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_4;
  mediump vec3 tmpvar_30;
  tmpvar_30 = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_4;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
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