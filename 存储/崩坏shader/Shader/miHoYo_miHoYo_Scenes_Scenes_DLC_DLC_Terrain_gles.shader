//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_Terrain" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Control Tex (RGBA)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _Splat0Tex ("Splat0 Tex (RGB)", 2D) = "black" { }
[MHYTextureScaleOffset] _Splat0Tex_ST ("Splat0Tex_ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _Splat1Tex ("Splat1 Tex (RGB)", 2D) = "black" { }
[MHYTextureScaleOffset] _Splat1Tex_ST ("Splat1Tex_ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _Splat2Tex ("Splat2 Tex (RGB)", 2D) = "black" { }
[MHYTextureScaleOffset] _Splat2Tex_ST ("Splat2Tex_ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _Splat3Tex ("Splat3 Tex (RGB)", 2D) = "black" { }
[MHYTextureScaleOffset] _Splat3Tex_ST ("Splat3Tex_ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (0,0,0,0)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
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
  GpuProgramID 43935
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = (((
    (((Splat0_Color_6 * Control_Color_7.x) + (Splat1_Color_5 * Control_Color_7.y)) + (Splat2_Color_4 * Control_Color_7.z))
   + 
    (Splat3_Color_3 * Control_Color_7.w)
  ).xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = (((
    (((Splat0_Color_6 * Control_Color_7.x) + (Splat1_Color_5 * Control_Color_7.y)) + (Splat2_Color_4 * Control_Color_7.z))
   + 
    (Splat3_Color_3 * Control_Color_7.w)
  ).xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = (((
    (((Splat0_Color_6 * Control_Color_7.x) + (Splat1_Color_5 * Control_Color_7.y)) + (Splat2_Color_4 * Control_Color_7.z))
   + 
    (Splat3_Color_3 * Control_Color_7.w)
  ).xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = (((
    (((Splat0_Color_6 * Control_Color_7.x) + (Splat1_Color_5 * Control_Color_7.y)) + (Splat2_Color_4 * Control_Color_7.z))
   + 
    (Splat3_Color_3 * Control_Color_7.w)
  ).xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = (((
    (((Splat0_Color_6 * Control_Color_7.x) + (Splat1_Color_5 * Control_Color_7.y)) + (Splat2_Color_4 * Control_Color_7.z))
   + 
    (Splat3_Color_3 * Control_Color_7.w)
  ).xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = (((
    (((Splat0_Color_6 * Control_Color_7.x) + (Splat1_Color_5 * Control_Color_7.y)) + (Splat2_Color_4 * Control_Color_7.z))
   + 
    (Splat3_Color_3 * Control_Color_7.w)
  ).xyz * _Color.xyz) * ((
    (lmtex_8.xyz * _ShadowColor)
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((
    (Splat0_Color_6 * Control_Color_7.x)
   + 
    (Splat1_Color_5 * Control_Color_7.y)
  ) + (Splat2_Color_4 * Control_Color_7.z)) + (Splat3_Color_3 * Control_Color_7.w));
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tmpvar_16.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_20;
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_2;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_2;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((
    (Splat0_Color_6 * Control_Color_7.x)
   + 
    (Splat1_Color_5 * Control_Color_7.y)
  ) + (Splat2_Color_4 * Control_Color_7.z)) + (Splat3_Color_3 * Control_Color_7.w));
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tmpvar_16.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_20;
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_2;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_2;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((
    (Splat0_Color_6 * Control_Color_7.x)
   + 
    (Splat1_Color_5 * Control_Color_7.y)
  ) + (Splat2_Color_4 * Control_Color_7.z)) + (Splat3_Color_3 * Control_Color_7.w));
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tmpvar_16.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_20;
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_2;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_2;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((
    (Splat0_Color_6 * Control_Color_7.x)
   + 
    (Splat1_Color_5 * Control_Color_7.y)
  ) + (Splat2_Color_4 * Control_Color_7.z)) + (Splat3_Color_3 * Control_Color_7.w));
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tmpvar_16.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_20;
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_2;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_2;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((
    (Splat0_Color_6 * Control_Color_7.x)
   + 
    (Splat1_Color_5 * Control_Color_7.y)
  ) + (Splat2_Color_4 * Control_Color_7.z)) + (Splat3_Color_3 * Control_Color_7.w));
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tmpvar_16.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_20;
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_2;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_2;
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
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  tmpvar_2 = _glesColor;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  tmpvar_3 = normalize((_glesNormal * tmpvar_11));
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
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump float _BloomIntensity;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec4 Splat3_Color_3;
  mediump vec4 Splat2_Color_4;
  mediump vec4 Splat1_Color_5;
  mediump vec4 Splat0_Color_6;
  mediump vec4 Control_Color_7;
  mediump vec4 lmtex_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_8.w = tmpvar_9.w;
  lowp vec4 color_10;
  color_10 = tmpvar_9;
  lmtex_8.xyz = (unity_Lightmap_HDR.x * color_10.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Control_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat0Tex, xlv_TEXCOORD4.xy);
  Splat0_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat1Tex, xlv_TEXCOORD4.zw);
  Splat1_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat2Tex, xlv_TEXCOORD5.xy);
  Splat2_Color_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat3Tex, xlv_TEXCOORD5.zw);
  Splat3_Color_3 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((
    (Splat0_Color_6 * Control_Color_7.x)
   + 
    (Splat1_Color_5 * Control_Color_7.y)
  ) + (Splat2_Color_4 * Control_Color_7.z)) + (Splat3_Color_3 * Control_Color_7.w));
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tmpvar_16.xyz * _Color.xyz) * ((
    ((lmtex_8.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_8.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_18))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_2 = tmpvar_20;
  mediump vec3 srcColor_21;
  srcColor_21 = colorBlendLightMap_2;
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (srcColor_21, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = colorBlendLightMap_2;
  tmpvar_23.w = _BloomIntensity;
  tmpvar_1 = tmpvar_23;
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
CustomEditor "MoleMoleEditor.CharacterAvatarShaderGUI"
}