//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_FakeWindow_LightMap" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_BackTex ("Back", 2D) = "white" { }
_BackDark ("Back Dark", Float) = 0.7
_BackDepthScale ("Back Depth Scale", Range(0, 1)) = 0
_MidTex ("Mid", 2D) = "white" { }
_MidDark ("Mid Dark", Float) = 0.3
_MidDepthScale ("Mid Depth Scale", Range(0, 1)) = 0.3
_FrontTex ("Front", 2D) = "white" { }
_MaskTex ("Mask", 2D) = "white" { }
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (1,1,0,0)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
_FogTune ("Fog Tune", Range(0, 1)) = 1
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_Specular ("Specular", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
[Toggle(LUMINANCE)] _Luminance ("Luminance", Float) = 0
_LumiFactor ("Luminance Factor", Float) = 0
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+0" "RenderType" = "Opaque" }
  GpuProgramID 50560
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
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
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  mediump vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lmtex_3.w = tmpvar_25.w;
  lowp vec4 color_26;
  color_26 = tmpvar_25;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_26.xyz);
  highp vec3 tmpvar_27;
  tmpvar_27 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_29, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = outColor_9.xyz;
  tmpvar_30.w = _BloomFactor;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
uniform mediump vec4 _FrontTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float tangentSign_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = vec2(0.0, 0.0);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = tmpvar_14.x;
  tmpvar_15.z = worldNormal_3.x;
  tmpvar_15.w = tmpvar_8.x;
  highp vec4 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = tmpvar_14.y;
  tmpvar_16.z = worldNormal_3.y;
  tmpvar_16.w = tmpvar_8.y;
  highp vec4 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = tmpvar_14.z;
  tmpvar_17.z = worldNormal_3.z;
  tmpvar_17.w = tmpvar_8.z;
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _BackTex;
uniform mediump float _BackDepthScale;
uniform mediump float _BackDark;
uniform sampler2D _MidTex;
uniform mediump float _MidDepthScale;
uniform mediump float _MidDark;
uniform sampler2D _MaskTex;
uniform sampler2D _FrontTex;
uniform mediump vec3 _LightingColor;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec3 worldNormal_4;
  mediump vec4 tex_C_Color_5;
  mediump float wallMask_6;
  mediump vec3 viewDir_7;
  mediump vec3 worldViewDir_8;
  mediump vec4 outColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.w;
  tmpvar_10.y = xlv_TEXCOORD1.w;
  tmpvar_10.z = xlv_TEXCOORD2.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
  worldViewDir_8 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0.xyz * worldViewDir_8.x) + (xlv_TEXCOORD1.xyz * worldViewDir_8.y)) + (xlv_TEXCOORD2.xyz * worldViewDir_8.z));
  viewDir_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((-(viewDir_7.xy) * _BackDepthScale) + xlv_TEXCOORD3);
  highp vec2 tmpvar_14;
  tmpvar_14 = ((-(viewDir_7.xy) * _MidDepthScale) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_BackTex, tmpvar_13);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MidTex, tmpvar_14);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_14).yyyy;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, xlv_TEXCOORD3).x;
  wallMask_6 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FrontTex, xlv_TEXCOORD3);
  mediump vec3 tmpvar_20;
  tmpvar_20 = mix (mix ((tmpvar_15 * _BackDark), (tmpvar_16 * _MidDark), tmpvar_17).xyz, tmpvar_19.xyz, vec3(wallMask_6));
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  tex_C_Color_5.w = tmpvar_21.w;
  highp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.z;
  tmpvar_22.y = xlv_TEXCOORD1.z;
  tmpvar_22.z = xlv_TEXCOORD2.z;
  worldNormal_4 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (worldViewDir_8 - (2.0 * (
    dot (worldNormal_4, worldViewDir_8)
   * worldNormal_4)));
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_EnvTex, tmpvar_23);
  tex_C_Color_5.xyz = (tmpvar_20 + ((
    (1.0 - wallMask_6)
   * tmpvar_24.xyz) * _Reflectivity));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD4);
  lmtex_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tex_C_Color_5.xyz * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_27;
  mediump vec3 srcColor_28;
  srcColor_28 = colorBlendLightMap_1;
  outColor_9.xyz = mix (srcColor_28, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.w = _BloomFactor;
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = outColor_9.xyz;
  tmpvar_29.w = _BloomFactor;
  gl_FragData[0] = tmpvar_29;
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
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
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
Keywords { "LUMINANCE" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_LightMap_ON" }
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
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_LightMap_ON" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
}
}
}
Fallback "Diffuse"
}