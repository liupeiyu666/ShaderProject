//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMapUnity_ReflectionProbe_Emission_AddLight" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo", 2D) = "white" { }
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
_Color ("Color", Color) = (1,1,1,1)
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "white" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (0,0,0,0)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[MHYHeaderBox(Reflecting)] _ReflectMaskTex ("Reflect Mask Tex(R,G)", 2D) = "white" { }
_ReflectionAdjust ("Reflection(RG:Strength, BA:Dark", Vector) = (1,1,0,0)
_Smoothness ("Smoothness", Range(0, 1)) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
[Toggle(BUMPMAP_ON)] _EnableBumpMap ("Enable Bump Map", Float) = 0
_BrushedNormalMap ("Brushed Normal Map", 2D) = "bump" { }
_BrushScale ("Brush Scale", Range(0, 1)) = 1
[MHYHeaderBox(Emission)] [Toggle(EMISSION_MASK_ON)] _EnableEmissionMask ("Enable Emission Mask", Float) = 0
_EmissionMask ("Emission Mask", 2D) = "black" { }
[Enum(R,0,G,1,B,2)] _UseChannel ("Use Channel", Float) = 1
[Enum(UV1st,0,UV2nd,1)] _UseSet ("UV Set", Float) = 1
_Emission ("Emission Color", Color) = (0,0,0,0.5)
_EmissionGIIntensity ("Emission GI Intensity", Range(0, 10)) = 2
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_LightMapIntensity ("Light Map Intensity", Range(0, 5)) = 1.5
_FogTune ("Fog Tune", Range(0, 1)) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
[MHYHeaderBox(ADDLIGHT)] _AdditiveLightPower ("Additive Light Power", Range(0.1, 5)) = 1
_AdditiveLightIntensity ("Additive Light Intensity", Range(0, 1)) = 1
}
SubShader {
 LOD 600
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  LOD 600
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 23758
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_18;
  mediump float tmpvar_19;
  mediump vec3 N_20;
  N_20 = xlv_TEXCOORD4;
  tmpvar_19 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_20)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_29;
  mediump vec3 I_30;
  I_30 = -(I_11);
  tmpvar_29 = (I_30 - (2.0 * (
    dot (tmpvar_28, I_30)
   * tmpvar_28)));
  worldRef_6 = tmpvar_29;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_33;
  direction_33 = worldRef_6;
  highp vec3 position_34;
  position_34 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_35;
    tmpvar_35 = greaterThan (direction_33, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_36;
    if (tmpvar_35.x) {
      tmpvar_36 = tmpvar_32.x;
    } else {
      tmpvar_36 = tmpvar_31.x;
    };
    highp float tmpvar_37;
    if (tmpvar_35.y) {
      tmpvar_37 = tmpvar_32.y;
    } else {
      tmpvar_37 = tmpvar_31.y;
    };
    highp float tmpvar_38;
    if (tmpvar_35.z) {
      tmpvar_38 = tmpvar_32.z;
    } else {
      tmpvar_38 = tmpvar_31.z;
    };
    highp vec3 tmpvar_39;
    tmpvar_39.x = tmpvar_36;
    tmpvar_39.y = tmpvar_37;
    tmpvar_39.z = tmpvar_38;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((tmpvar_39 - position_34) / direction_33);
    direction_33 = ((direction_33 * min (
      min (tmpvar_40.x, tmpvar_40.y)
    , tmpvar_40.z)) + (position_34 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_33;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = projectRef_5;
  tmpvar_41.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_42;
  tmpvar_42 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_41.w);
  mediump vec4 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_43.w - 1.0)) + 1.0))
   * tmpvar_43.xyz) * tmpvar_23) * tmpvar_19);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (tmpvar_44, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMask, tmpvar_45.xy).xyz;
  emissionTex_2 = tmpvar_46;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_47;
    tmpvar_47 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_47;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = colorBlendLightMap_12;
  tmpvar_48.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_48;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_18;
  mediump float tmpvar_19;
  mediump vec3 N_20;
  N_20 = xlv_TEXCOORD4;
  tmpvar_19 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_20)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_29;
  mediump vec3 I_30;
  I_30 = -(I_11);
  tmpvar_29 = (I_30 - (2.0 * (
    dot (tmpvar_28, I_30)
   * tmpvar_28)));
  worldRef_6 = tmpvar_29;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_33;
  direction_33 = worldRef_6;
  highp vec3 position_34;
  position_34 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_35;
    tmpvar_35 = greaterThan (direction_33, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_36;
    if (tmpvar_35.x) {
      tmpvar_36 = tmpvar_32.x;
    } else {
      tmpvar_36 = tmpvar_31.x;
    };
    highp float tmpvar_37;
    if (tmpvar_35.y) {
      tmpvar_37 = tmpvar_32.y;
    } else {
      tmpvar_37 = tmpvar_31.y;
    };
    highp float tmpvar_38;
    if (tmpvar_35.z) {
      tmpvar_38 = tmpvar_32.z;
    } else {
      tmpvar_38 = tmpvar_31.z;
    };
    highp vec3 tmpvar_39;
    tmpvar_39.x = tmpvar_36;
    tmpvar_39.y = tmpvar_37;
    tmpvar_39.z = tmpvar_38;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((tmpvar_39 - position_34) / direction_33);
    direction_33 = ((direction_33 * min (
      min (tmpvar_40.x, tmpvar_40.y)
    , tmpvar_40.z)) + (position_34 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_33;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = projectRef_5;
  tmpvar_41.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_42;
  tmpvar_42 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_41.w);
  mediump vec4 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_43.w - 1.0)) + 1.0))
   * tmpvar_43.xyz) * tmpvar_23) * tmpvar_19);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (tmpvar_44, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMask, tmpvar_45.xy).xyz;
  emissionTex_2 = tmpvar_46;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_47;
    tmpvar_47 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_47;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = colorBlendLightMap_12;
  tmpvar_48.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_48;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_18;
  mediump float tmpvar_19;
  mediump vec3 N_20;
  N_20 = xlv_TEXCOORD4;
  tmpvar_19 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_20)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_29;
  mediump vec3 I_30;
  I_30 = -(I_11);
  tmpvar_29 = (I_30 - (2.0 * (
    dot (tmpvar_28, I_30)
   * tmpvar_28)));
  worldRef_6 = tmpvar_29;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_33;
  direction_33 = worldRef_6;
  highp vec3 position_34;
  position_34 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_35;
    tmpvar_35 = greaterThan (direction_33, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_36;
    if (tmpvar_35.x) {
      tmpvar_36 = tmpvar_32.x;
    } else {
      tmpvar_36 = tmpvar_31.x;
    };
    highp float tmpvar_37;
    if (tmpvar_35.y) {
      tmpvar_37 = tmpvar_32.y;
    } else {
      tmpvar_37 = tmpvar_31.y;
    };
    highp float tmpvar_38;
    if (tmpvar_35.z) {
      tmpvar_38 = tmpvar_32.z;
    } else {
      tmpvar_38 = tmpvar_31.z;
    };
    highp vec3 tmpvar_39;
    tmpvar_39.x = tmpvar_36;
    tmpvar_39.y = tmpvar_37;
    tmpvar_39.z = tmpvar_38;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((tmpvar_39 - position_34) / direction_33);
    direction_33 = ((direction_33 * min (
      min (tmpvar_40.x, tmpvar_40.y)
    , tmpvar_40.z)) + (position_34 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_33;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = projectRef_5;
  tmpvar_41.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_42;
  tmpvar_42 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_41.w);
  mediump vec4 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_43.w - 1.0)) + 1.0))
   * tmpvar_43.xyz) * tmpvar_23) * tmpvar_19);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (tmpvar_44, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMask, tmpvar_45.xy).xyz;
  emissionTex_2 = tmpvar_46;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_47;
    tmpvar_47 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_47;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = colorBlendLightMap_12;
  tmpvar_48.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_48;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_18;
  mediump float tmpvar_19;
  mediump vec3 N_20;
  N_20 = xlv_TEXCOORD4;
  tmpvar_19 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_20)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_29;
  mediump vec3 I_30;
  I_30 = -(I_11);
  tmpvar_29 = (I_30 - (2.0 * (
    dot (tmpvar_28, I_30)
   * tmpvar_28)));
  worldRef_6 = tmpvar_29;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_33;
  direction_33 = worldRef_6;
  highp vec3 position_34;
  position_34 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_35;
    tmpvar_35 = greaterThan (direction_33, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_36;
    if (tmpvar_35.x) {
      tmpvar_36 = tmpvar_32.x;
    } else {
      tmpvar_36 = tmpvar_31.x;
    };
    highp float tmpvar_37;
    if (tmpvar_35.y) {
      tmpvar_37 = tmpvar_32.y;
    } else {
      tmpvar_37 = tmpvar_31.y;
    };
    highp float tmpvar_38;
    if (tmpvar_35.z) {
      tmpvar_38 = tmpvar_32.z;
    } else {
      tmpvar_38 = tmpvar_31.z;
    };
    highp vec3 tmpvar_39;
    tmpvar_39.x = tmpvar_36;
    tmpvar_39.y = tmpvar_37;
    tmpvar_39.z = tmpvar_38;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((tmpvar_39 - position_34) / direction_33);
    direction_33 = ((direction_33 * min (
      min (tmpvar_40.x, tmpvar_40.y)
    , tmpvar_40.z)) + (position_34 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_33;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = projectRef_5;
  tmpvar_41.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_42;
  tmpvar_42 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_41.w);
  mediump vec4 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_43.w - 1.0)) + 1.0))
   * tmpvar_43.xyz) * tmpvar_23) * tmpvar_19);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (tmpvar_44, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMask, tmpvar_45.xy).xyz;
  emissionTex_2 = tmpvar_46;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_47;
    tmpvar_47 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_47;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = colorBlendLightMap_12;
  tmpvar_48.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_48;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_18;
  mediump float tmpvar_19;
  mediump vec3 N_20;
  N_20 = xlv_TEXCOORD4;
  tmpvar_19 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_20)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_29;
  mediump vec3 I_30;
  I_30 = -(I_11);
  tmpvar_29 = (I_30 - (2.0 * (
    dot (tmpvar_28, I_30)
   * tmpvar_28)));
  worldRef_6 = tmpvar_29;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_33;
  direction_33 = worldRef_6;
  highp vec3 position_34;
  position_34 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_35;
    tmpvar_35 = greaterThan (direction_33, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_36;
    if (tmpvar_35.x) {
      tmpvar_36 = tmpvar_32.x;
    } else {
      tmpvar_36 = tmpvar_31.x;
    };
    highp float tmpvar_37;
    if (tmpvar_35.y) {
      tmpvar_37 = tmpvar_32.y;
    } else {
      tmpvar_37 = tmpvar_31.y;
    };
    highp float tmpvar_38;
    if (tmpvar_35.z) {
      tmpvar_38 = tmpvar_32.z;
    } else {
      tmpvar_38 = tmpvar_31.z;
    };
    highp vec3 tmpvar_39;
    tmpvar_39.x = tmpvar_36;
    tmpvar_39.y = tmpvar_37;
    tmpvar_39.z = tmpvar_38;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((tmpvar_39 - position_34) / direction_33);
    direction_33 = ((direction_33 * min (
      min (tmpvar_40.x, tmpvar_40.y)
    , tmpvar_40.z)) + (position_34 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_33;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = projectRef_5;
  tmpvar_41.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_42;
  tmpvar_42 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_41.w);
  mediump vec4 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_43.w - 1.0)) + 1.0))
   * tmpvar_43.xyz) * tmpvar_23) * tmpvar_19);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (tmpvar_44, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMask, tmpvar_45.xy).xyz;
  emissionTex_2 = tmpvar_46;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_47;
    tmpvar_47 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_47;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = colorBlendLightMap_12;
  tmpvar_48.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_48;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_18;
  mediump float tmpvar_19;
  mediump vec3 N_20;
  N_20 = xlv_TEXCOORD4;
  tmpvar_19 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_20)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_29;
  mediump vec3 I_30;
  I_30 = -(I_11);
  tmpvar_29 = (I_30 - (2.0 * (
    dot (tmpvar_28, I_30)
   * tmpvar_28)));
  worldRef_6 = tmpvar_29;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_33;
  direction_33 = worldRef_6;
  highp vec3 position_34;
  position_34 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_35;
    tmpvar_35 = greaterThan (direction_33, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_36;
    if (tmpvar_35.x) {
      tmpvar_36 = tmpvar_32.x;
    } else {
      tmpvar_36 = tmpvar_31.x;
    };
    highp float tmpvar_37;
    if (tmpvar_35.y) {
      tmpvar_37 = tmpvar_32.y;
    } else {
      tmpvar_37 = tmpvar_31.y;
    };
    highp float tmpvar_38;
    if (tmpvar_35.z) {
      tmpvar_38 = tmpvar_32.z;
    } else {
      tmpvar_38 = tmpvar_31.z;
    };
    highp vec3 tmpvar_39;
    tmpvar_39.x = tmpvar_36;
    tmpvar_39.y = tmpvar_37;
    tmpvar_39.z = tmpvar_38;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((tmpvar_39 - position_34) / direction_33);
    direction_33 = ((direction_33 * min (
      min (tmpvar_40.x, tmpvar_40.y)
    , tmpvar_40.z)) + (position_34 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_33;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = projectRef_5;
  tmpvar_41.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_42;
  tmpvar_42 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_41.w);
  mediump vec4 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_43.w - 1.0)) + 1.0))
   * tmpvar_43.xyz) * tmpvar_23) * tmpvar_19);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (tmpvar_44, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMask, tmpvar_45.xy).xyz;
  emissionTex_2 = tmpvar_46;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_47;
    tmpvar_47 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_47;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = colorBlendLightMap_12;
  tmpvar_48.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_48;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD4;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_28;
  mediump vec3 I_29;
  I_29 = -(I_11);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_27, I_29)
   * tmpvar_27)));
  worldRef_6 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_32;
  direction_32 = worldRef_6;
  highp vec3 position_33;
  position_33 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_34;
    tmpvar_34 = greaterThan (direction_32, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_35;
    if (tmpvar_34.x) {
      tmpvar_35 = tmpvar_31.x;
    } else {
      tmpvar_35 = tmpvar_30.x;
    };
    highp float tmpvar_36;
    if (tmpvar_34.y) {
      tmpvar_36 = tmpvar_31.y;
    } else {
      tmpvar_36 = tmpvar_30.y;
    };
    highp float tmpvar_37;
    if (tmpvar_34.z) {
      tmpvar_37 = tmpvar_31.z;
    } else {
      tmpvar_37 = tmpvar_30.z;
    };
    highp vec3 tmpvar_38;
    tmpvar_38.x = tmpvar_35;
    tmpvar_38.y = tmpvar_36;
    tmpvar_38.z = tmpvar_37;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((tmpvar_38 - position_33) / direction_32);
    direction_32 = ((direction_32 * min (
      min (tmpvar_39.x, tmpvar_39.y)
    , tmpvar_39.z)) + (position_33 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_32;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = projectRef_5;
  tmpvar_40.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_41;
  tmpvar_41 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_40.w);
  mediump vec4 tmpvar_42;
  tmpvar_42 = tmpvar_41;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_42.w - 1.0)) + 1.0))
   * tmpvar_42.xyz) * tmpvar_22) * tmpvar_18);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (tmpvar_43, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_EmissionMask, tmpvar_44.xy).xyz;
  emissionTex_2 = tmpvar_45;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_46;
    tmpvar_46 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_46;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = colorBlendLightMap_12;
  tmpvar_47.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_47;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD4;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_28;
  mediump vec3 I_29;
  I_29 = -(I_11);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_27, I_29)
   * tmpvar_27)));
  worldRef_6 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_32;
  direction_32 = worldRef_6;
  highp vec3 position_33;
  position_33 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_34;
    tmpvar_34 = greaterThan (direction_32, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_35;
    if (tmpvar_34.x) {
      tmpvar_35 = tmpvar_31.x;
    } else {
      tmpvar_35 = tmpvar_30.x;
    };
    highp float tmpvar_36;
    if (tmpvar_34.y) {
      tmpvar_36 = tmpvar_31.y;
    } else {
      tmpvar_36 = tmpvar_30.y;
    };
    highp float tmpvar_37;
    if (tmpvar_34.z) {
      tmpvar_37 = tmpvar_31.z;
    } else {
      tmpvar_37 = tmpvar_30.z;
    };
    highp vec3 tmpvar_38;
    tmpvar_38.x = tmpvar_35;
    tmpvar_38.y = tmpvar_36;
    tmpvar_38.z = tmpvar_37;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((tmpvar_38 - position_33) / direction_32);
    direction_32 = ((direction_32 * min (
      min (tmpvar_39.x, tmpvar_39.y)
    , tmpvar_39.z)) + (position_33 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_32;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = projectRef_5;
  tmpvar_40.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_41;
  tmpvar_41 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_40.w);
  mediump vec4 tmpvar_42;
  tmpvar_42 = tmpvar_41;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_42.w - 1.0)) + 1.0))
   * tmpvar_42.xyz) * tmpvar_22) * tmpvar_18);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (tmpvar_43, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_EmissionMask, tmpvar_44.xy).xyz;
  emissionTex_2 = tmpvar_45;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_46;
    tmpvar_46 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_46;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = colorBlendLightMap_12;
  tmpvar_47.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_47;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD4;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_28;
  mediump vec3 I_29;
  I_29 = -(I_11);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_27, I_29)
   * tmpvar_27)));
  worldRef_6 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_32;
  direction_32 = worldRef_6;
  highp vec3 position_33;
  position_33 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_34;
    tmpvar_34 = greaterThan (direction_32, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_35;
    if (tmpvar_34.x) {
      tmpvar_35 = tmpvar_31.x;
    } else {
      tmpvar_35 = tmpvar_30.x;
    };
    highp float tmpvar_36;
    if (tmpvar_34.y) {
      tmpvar_36 = tmpvar_31.y;
    } else {
      tmpvar_36 = tmpvar_30.y;
    };
    highp float tmpvar_37;
    if (tmpvar_34.z) {
      tmpvar_37 = tmpvar_31.z;
    } else {
      tmpvar_37 = tmpvar_30.z;
    };
    highp vec3 tmpvar_38;
    tmpvar_38.x = tmpvar_35;
    tmpvar_38.y = tmpvar_36;
    tmpvar_38.z = tmpvar_37;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((tmpvar_38 - position_33) / direction_32);
    direction_32 = ((direction_32 * min (
      min (tmpvar_39.x, tmpvar_39.y)
    , tmpvar_39.z)) + (position_33 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_32;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = projectRef_5;
  tmpvar_40.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_41;
  tmpvar_41 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_40.w);
  mediump vec4 tmpvar_42;
  tmpvar_42 = tmpvar_41;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_42.w - 1.0)) + 1.0))
   * tmpvar_42.xyz) * tmpvar_22) * tmpvar_18);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (tmpvar_43, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_EmissionMask, tmpvar_44.xy).xyz;
  emissionTex_2 = tmpvar_45;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_46;
    tmpvar_46 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_46;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = colorBlendLightMap_12;
  tmpvar_47.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_47;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD4;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_28;
  mediump vec3 I_29;
  I_29 = -(I_11);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_27, I_29)
   * tmpvar_27)));
  worldRef_6 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_32;
  direction_32 = worldRef_6;
  highp vec3 position_33;
  position_33 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_34;
    tmpvar_34 = greaterThan (direction_32, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_35;
    if (tmpvar_34.x) {
      tmpvar_35 = tmpvar_31.x;
    } else {
      tmpvar_35 = tmpvar_30.x;
    };
    highp float tmpvar_36;
    if (tmpvar_34.y) {
      tmpvar_36 = tmpvar_31.y;
    } else {
      tmpvar_36 = tmpvar_30.y;
    };
    highp float tmpvar_37;
    if (tmpvar_34.z) {
      tmpvar_37 = tmpvar_31.z;
    } else {
      tmpvar_37 = tmpvar_30.z;
    };
    highp vec3 tmpvar_38;
    tmpvar_38.x = tmpvar_35;
    tmpvar_38.y = tmpvar_36;
    tmpvar_38.z = tmpvar_37;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((tmpvar_38 - position_33) / direction_32);
    direction_32 = ((direction_32 * min (
      min (tmpvar_39.x, tmpvar_39.y)
    , tmpvar_39.z)) + (position_33 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_32;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = projectRef_5;
  tmpvar_40.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_41;
  tmpvar_41 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_40.w);
  mediump vec4 tmpvar_42;
  tmpvar_42 = tmpvar_41;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_42.w - 1.0)) + 1.0))
   * tmpvar_42.xyz) * tmpvar_22) * tmpvar_18);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (tmpvar_43, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_EmissionMask, tmpvar_44.xy).xyz;
  emissionTex_2 = tmpvar_45;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_46;
    tmpvar_46 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_46;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = colorBlendLightMap_12;
  tmpvar_47.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_47;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD4;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_28;
  mediump vec3 I_29;
  I_29 = -(I_11);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_27, I_29)
   * tmpvar_27)));
  worldRef_6 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_32;
  direction_32 = worldRef_6;
  highp vec3 position_33;
  position_33 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_34;
    tmpvar_34 = greaterThan (direction_32, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_35;
    if (tmpvar_34.x) {
      tmpvar_35 = tmpvar_31.x;
    } else {
      tmpvar_35 = tmpvar_30.x;
    };
    highp float tmpvar_36;
    if (tmpvar_34.y) {
      tmpvar_36 = tmpvar_31.y;
    } else {
      tmpvar_36 = tmpvar_30.y;
    };
    highp float tmpvar_37;
    if (tmpvar_34.z) {
      tmpvar_37 = tmpvar_31.z;
    } else {
      tmpvar_37 = tmpvar_30.z;
    };
    highp vec3 tmpvar_38;
    tmpvar_38.x = tmpvar_35;
    tmpvar_38.y = tmpvar_36;
    tmpvar_38.z = tmpvar_37;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((tmpvar_38 - position_33) / direction_32);
    direction_32 = ((direction_32 * min (
      min (tmpvar_39.x, tmpvar_39.y)
    , tmpvar_39.z)) + (position_33 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_32;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = projectRef_5;
  tmpvar_40.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_41;
  tmpvar_41 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_40.w);
  mediump vec4 tmpvar_42;
  tmpvar_42 = tmpvar_41;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_42.w - 1.0)) + 1.0))
   * tmpvar_42.xyz) * tmpvar_22) * tmpvar_18);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (tmpvar_43, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_EmissionMask, tmpvar_44.xy).xyz;
  emissionTex_2 = tmpvar_45;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_46;
    tmpvar_46 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_46;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = colorBlendLightMap_12;
  tmpvar_47.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_47;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_17;
  mediump float tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD4;
  tmpvar_18 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_19)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_28;
  mediump vec3 I_29;
  I_29 = -(I_11);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_27, I_29)
   * tmpvar_27)));
  worldRef_6 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_32;
  direction_32 = worldRef_6;
  highp vec3 position_33;
  position_33 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_34;
    tmpvar_34 = greaterThan (direction_32, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_35;
    if (tmpvar_34.x) {
      tmpvar_35 = tmpvar_31.x;
    } else {
      tmpvar_35 = tmpvar_30.x;
    };
    highp float tmpvar_36;
    if (tmpvar_34.y) {
      tmpvar_36 = tmpvar_31.y;
    } else {
      tmpvar_36 = tmpvar_30.y;
    };
    highp float tmpvar_37;
    if (tmpvar_34.z) {
      tmpvar_37 = tmpvar_31.z;
    } else {
      tmpvar_37 = tmpvar_30.z;
    };
    highp vec3 tmpvar_38;
    tmpvar_38.x = tmpvar_35;
    tmpvar_38.y = tmpvar_36;
    tmpvar_38.z = tmpvar_37;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((tmpvar_38 - position_33) / direction_32);
    direction_32 = ((direction_32 * min (
      min (tmpvar_39.x, tmpvar_39.y)
    , tmpvar_39.z)) + (position_33 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_32;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = projectRef_5;
  tmpvar_40.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_41;
  tmpvar_41 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_40.w);
  mediump vec4 tmpvar_42;
  tmpvar_42 = tmpvar_41;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_42.w - 1.0)) + 1.0))
   * tmpvar_42.xyz) * tmpvar_22) * tmpvar_18);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (tmpvar_43, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_EmissionMask, tmpvar_44.xy).xyz;
  emissionTex_2 = tmpvar_45;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_46;
    tmpvar_46 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_46;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = colorBlendLightMap_12;
  tmpvar_47.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_47;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD4;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_30;
  mediump vec3 I_31;
  I_31 = -(I_11);
  tmpvar_30 = (I_31 - (2.0 * (
    dot (tmpvar_29, I_31)
   * tmpvar_29)));
  worldRef_6 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_34;
  direction_34 = worldRef_6;
  highp vec3 position_35;
  position_35 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_36;
    tmpvar_36 = greaterThan (direction_34, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_37;
    if (tmpvar_36.x) {
      tmpvar_37 = tmpvar_33.x;
    } else {
      tmpvar_37 = tmpvar_32.x;
    };
    highp float tmpvar_38;
    if (tmpvar_36.y) {
      tmpvar_38 = tmpvar_33.y;
    } else {
      tmpvar_38 = tmpvar_32.y;
    };
    highp float tmpvar_39;
    if (tmpvar_36.z) {
      tmpvar_39 = tmpvar_33.z;
    } else {
      tmpvar_39 = tmpvar_32.z;
    };
    highp vec3 tmpvar_40;
    tmpvar_40.x = tmpvar_37;
    tmpvar_40.y = tmpvar_38;
    tmpvar_40.z = tmpvar_39;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((tmpvar_40 - position_35) / direction_34);
    direction_34 = ((direction_34 * min (
      min (tmpvar_41.x, tmpvar_41.y)
    , tmpvar_41.z)) + (position_35 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_34;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = projectRef_5;
  tmpvar_42.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_44.w - 1.0)) + 1.0))
   * tmpvar_44.xyz) * tmpvar_24) * tmpvar_20);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (tmpvar_45, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_47;
  tmpvar_47 = texture2D (_EmissionMask, tmpvar_46.xy).xyz;
  emissionTex_2 = tmpvar_47;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_48;
    tmpvar_48 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_48;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = colorBlendLightMap_12;
  tmpvar_49.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_49;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD4;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_30;
  mediump vec3 I_31;
  I_31 = -(I_11);
  tmpvar_30 = (I_31 - (2.0 * (
    dot (tmpvar_29, I_31)
   * tmpvar_29)));
  worldRef_6 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_34;
  direction_34 = worldRef_6;
  highp vec3 position_35;
  position_35 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_36;
    tmpvar_36 = greaterThan (direction_34, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_37;
    if (tmpvar_36.x) {
      tmpvar_37 = tmpvar_33.x;
    } else {
      tmpvar_37 = tmpvar_32.x;
    };
    highp float tmpvar_38;
    if (tmpvar_36.y) {
      tmpvar_38 = tmpvar_33.y;
    } else {
      tmpvar_38 = tmpvar_32.y;
    };
    highp float tmpvar_39;
    if (tmpvar_36.z) {
      tmpvar_39 = tmpvar_33.z;
    } else {
      tmpvar_39 = tmpvar_32.z;
    };
    highp vec3 tmpvar_40;
    tmpvar_40.x = tmpvar_37;
    tmpvar_40.y = tmpvar_38;
    tmpvar_40.z = tmpvar_39;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((tmpvar_40 - position_35) / direction_34);
    direction_34 = ((direction_34 * min (
      min (tmpvar_41.x, tmpvar_41.y)
    , tmpvar_41.z)) + (position_35 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_34;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = projectRef_5;
  tmpvar_42.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_44.w - 1.0)) + 1.0))
   * tmpvar_44.xyz) * tmpvar_24) * tmpvar_20);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (tmpvar_45, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_47;
  tmpvar_47 = texture2D (_EmissionMask, tmpvar_46.xy).xyz;
  emissionTex_2 = tmpvar_47;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_48;
    tmpvar_48 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_48;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = colorBlendLightMap_12;
  tmpvar_49.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_49;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD4;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_30;
  mediump vec3 I_31;
  I_31 = -(I_11);
  tmpvar_30 = (I_31 - (2.0 * (
    dot (tmpvar_29, I_31)
   * tmpvar_29)));
  worldRef_6 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_34;
  direction_34 = worldRef_6;
  highp vec3 position_35;
  position_35 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_36;
    tmpvar_36 = greaterThan (direction_34, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_37;
    if (tmpvar_36.x) {
      tmpvar_37 = tmpvar_33.x;
    } else {
      tmpvar_37 = tmpvar_32.x;
    };
    highp float tmpvar_38;
    if (tmpvar_36.y) {
      tmpvar_38 = tmpvar_33.y;
    } else {
      tmpvar_38 = tmpvar_32.y;
    };
    highp float tmpvar_39;
    if (tmpvar_36.z) {
      tmpvar_39 = tmpvar_33.z;
    } else {
      tmpvar_39 = tmpvar_32.z;
    };
    highp vec3 tmpvar_40;
    tmpvar_40.x = tmpvar_37;
    tmpvar_40.y = tmpvar_38;
    tmpvar_40.z = tmpvar_39;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((tmpvar_40 - position_35) / direction_34);
    direction_34 = ((direction_34 * min (
      min (tmpvar_41.x, tmpvar_41.y)
    , tmpvar_41.z)) + (position_35 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_34;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = projectRef_5;
  tmpvar_42.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_44.w - 1.0)) + 1.0))
   * tmpvar_44.xyz) * tmpvar_24) * tmpvar_20);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (tmpvar_45, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_47;
  tmpvar_47 = texture2D (_EmissionMask, tmpvar_46.xy).xyz;
  emissionTex_2 = tmpvar_47;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_48;
    tmpvar_48 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_48;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = colorBlendLightMap_12;
  tmpvar_49.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_49;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD4;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_30;
  mediump vec3 I_31;
  I_31 = -(I_11);
  tmpvar_30 = (I_31 - (2.0 * (
    dot (tmpvar_29, I_31)
   * tmpvar_29)));
  worldRef_6 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_34;
  direction_34 = worldRef_6;
  highp vec3 position_35;
  position_35 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_36;
    tmpvar_36 = greaterThan (direction_34, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_37;
    if (tmpvar_36.x) {
      tmpvar_37 = tmpvar_33.x;
    } else {
      tmpvar_37 = tmpvar_32.x;
    };
    highp float tmpvar_38;
    if (tmpvar_36.y) {
      tmpvar_38 = tmpvar_33.y;
    } else {
      tmpvar_38 = tmpvar_32.y;
    };
    highp float tmpvar_39;
    if (tmpvar_36.z) {
      tmpvar_39 = tmpvar_33.z;
    } else {
      tmpvar_39 = tmpvar_32.z;
    };
    highp vec3 tmpvar_40;
    tmpvar_40.x = tmpvar_37;
    tmpvar_40.y = tmpvar_38;
    tmpvar_40.z = tmpvar_39;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((tmpvar_40 - position_35) / direction_34);
    direction_34 = ((direction_34 * min (
      min (tmpvar_41.x, tmpvar_41.y)
    , tmpvar_41.z)) + (position_35 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_34;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = projectRef_5;
  tmpvar_42.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_44.w - 1.0)) + 1.0))
   * tmpvar_44.xyz) * tmpvar_24) * tmpvar_20);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (tmpvar_45, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_47;
  tmpvar_47 = texture2D (_EmissionMask, tmpvar_46.xy).xyz;
  emissionTex_2 = tmpvar_47;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_48;
    tmpvar_48 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_48;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = colorBlendLightMap_12;
  tmpvar_49.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_49;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD4;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_30;
  mediump vec3 I_31;
  I_31 = -(I_11);
  tmpvar_30 = (I_31 - (2.0 * (
    dot (tmpvar_29, I_31)
   * tmpvar_29)));
  worldRef_6 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_34;
  direction_34 = worldRef_6;
  highp vec3 position_35;
  position_35 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_36;
    tmpvar_36 = greaterThan (direction_34, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_37;
    if (tmpvar_36.x) {
      tmpvar_37 = tmpvar_33.x;
    } else {
      tmpvar_37 = tmpvar_32.x;
    };
    highp float tmpvar_38;
    if (tmpvar_36.y) {
      tmpvar_38 = tmpvar_33.y;
    } else {
      tmpvar_38 = tmpvar_32.y;
    };
    highp float tmpvar_39;
    if (tmpvar_36.z) {
      tmpvar_39 = tmpvar_33.z;
    } else {
      tmpvar_39 = tmpvar_32.z;
    };
    highp vec3 tmpvar_40;
    tmpvar_40.x = tmpvar_37;
    tmpvar_40.y = tmpvar_38;
    tmpvar_40.z = tmpvar_39;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((tmpvar_40 - position_35) / direction_34);
    direction_34 = ((direction_34 * min (
      min (tmpvar_41.x, tmpvar_41.y)
    , tmpvar_41.z)) + (position_35 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_34;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = projectRef_5;
  tmpvar_42.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_44.w - 1.0)) + 1.0))
   * tmpvar_44.xyz) * tmpvar_24) * tmpvar_20);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (tmpvar_45, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_47;
  tmpvar_47 = texture2D (_EmissionMask, tmpvar_46.xy).xyz;
  emissionTex_2 = tmpvar_47;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_48;
    tmpvar_48 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_48;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = colorBlendLightMap_12;
  tmpvar_49.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_49;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_19;
  mediump float tmpvar_20;
  mediump vec3 N_21;
  N_21 = xlv_TEXCOORD4;
  tmpvar_20 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_21)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    ((lmtex_14.xyz * _ShadowColor) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_30;
  mediump vec3 I_31;
  I_31 = -(I_11);
  tmpvar_30 = (I_31 - (2.0 * (
    dot (tmpvar_29, I_31)
   * tmpvar_29)));
  worldRef_6 = tmpvar_30;
  highp vec3 tmpvar_32;
  tmpvar_32 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_34;
  direction_34 = worldRef_6;
  highp vec3 position_35;
  position_35 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_36;
    tmpvar_36 = greaterThan (direction_34, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_37;
    if (tmpvar_36.x) {
      tmpvar_37 = tmpvar_33.x;
    } else {
      tmpvar_37 = tmpvar_32.x;
    };
    highp float tmpvar_38;
    if (tmpvar_36.y) {
      tmpvar_38 = tmpvar_33.y;
    } else {
      tmpvar_38 = tmpvar_32.y;
    };
    highp float tmpvar_39;
    if (tmpvar_36.z) {
      tmpvar_39 = tmpvar_33.z;
    } else {
      tmpvar_39 = tmpvar_32.z;
    };
    highp vec3 tmpvar_40;
    tmpvar_40.x = tmpvar_37;
    tmpvar_40.y = tmpvar_38;
    tmpvar_40.z = tmpvar_39;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((tmpvar_40 - position_35) / direction_34);
    direction_34 = ((direction_34 * min (
      min (tmpvar_41.x, tmpvar_41.y)
    , tmpvar_41.z)) + (position_35 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_34;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = projectRef_5;
  tmpvar_42.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_44.w - 1.0)) + 1.0))
   * tmpvar_44.xyz) * tmpvar_24) * tmpvar_20);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (tmpvar_45, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_47;
  tmpvar_47 = texture2D (_EmissionMask, tmpvar_46.xy).xyz;
  emissionTex_2 = tmpvar_47;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_48;
    tmpvar_48 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_48;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_49;
  tmpvar_49.xyz = colorBlendLightMap_12;
  tmpvar_49.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_49;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_21;
  mediump float tmpvar_22;
  mediump vec3 N_23;
  N_23 = xlv_TEXCOORD4;
  tmpvar_22 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_23)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_24;
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_19)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_32;
  mediump vec3 I_33;
  I_33 = -(I_11);
  tmpvar_32 = (I_33 - (2.0 * (
    dot (tmpvar_31, I_33)
   * tmpvar_31)));
  worldRef_6 = tmpvar_32;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_36;
  direction_36 = worldRef_6;
  highp vec3 position_37;
  position_37 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_38;
    tmpvar_38 = greaterThan (direction_36, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_39;
    if (tmpvar_38.x) {
      tmpvar_39 = tmpvar_35.x;
    } else {
      tmpvar_39 = tmpvar_34.x;
    };
    highp float tmpvar_40;
    if (tmpvar_38.y) {
      tmpvar_40 = tmpvar_35.y;
    } else {
      tmpvar_40 = tmpvar_34.y;
    };
    highp float tmpvar_41;
    if (tmpvar_38.z) {
      tmpvar_41 = tmpvar_35.z;
    } else {
      tmpvar_41 = tmpvar_34.z;
    };
    highp vec3 tmpvar_42;
    tmpvar_42.x = tmpvar_39;
    tmpvar_42.y = tmpvar_40;
    tmpvar_42.z = tmpvar_41;
    highp vec3 tmpvar_43;
    tmpvar_43 = ((tmpvar_42 - position_37) / direction_36);
    direction_36 = ((direction_36 * min (
      min (tmpvar_43.x, tmpvar_43.y)
    , tmpvar_43.z)) + (position_37 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_36;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = projectRef_5;
  tmpvar_44.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_46.w - 1.0)) + 1.0))
   * tmpvar_46.xyz) * tmpvar_26) * tmpvar_22);
  highp vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 0.0);
  tmpvar_47.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (tmpvar_47, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_49;
  tmpvar_49 = texture2D (_EmissionMask, tmpvar_48.xy).xyz;
  emissionTex_2 = tmpvar_49;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_50;
    tmpvar_50 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_50;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = colorBlendLightMap_12;
  tmpvar_51.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_51;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_21;
  mediump float tmpvar_22;
  mediump vec3 N_23;
  N_23 = xlv_TEXCOORD4;
  tmpvar_22 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_23)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_24;
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_19)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_32;
  mediump vec3 I_33;
  I_33 = -(I_11);
  tmpvar_32 = (I_33 - (2.0 * (
    dot (tmpvar_31, I_33)
   * tmpvar_31)));
  worldRef_6 = tmpvar_32;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_36;
  direction_36 = worldRef_6;
  highp vec3 position_37;
  position_37 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_38;
    tmpvar_38 = greaterThan (direction_36, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_39;
    if (tmpvar_38.x) {
      tmpvar_39 = tmpvar_35.x;
    } else {
      tmpvar_39 = tmpvar_34.x;
    };
    highp float tmpvar_40;
    if (tmpvar_38.y) {
      tmpvar_40 = tmpvar_35.y;
    } else {
      tmpvar_40 = tmpvar_34.y;
    };
    highp float tmpvar_41;
    if (tmpvar_38.z) {
      tmpvar_41 = tmpvar_35.z;
    } else {
      tmpvar_41 = tmpvar_34.z;
    };
    highp vec3 tmpvar_42;
    tmpvar_42.x = tmpvar_39;
    tmpvar_42.y = tmpvar_40;
    tmpvar_42.z = tmpvar_41;
    highp vec3 tmpvar_43;
    tmpvar_43 = ((tmpvar_42 - position_37) / direction_36);
    direction_36 = ((direction_36 * min (
      min (tmpvar_43.x, tmpvar_43.y)
    , tmpvar_43.z)) + (position_37 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_36;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = projectRef_5;
  tmpvar_44.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_46.w - 1.0)) + 1.0))
   * tmpvar_46.xyz) * tmpvar_26) * tmpvar_22);
  highp vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 0.0);
  tmpvar_47.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (tmpvar_47, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_49;
  tmpvar_49 = texture2D (_EmissionMask, tmpvar_48.xy).xyz;
  emissionTex_2 = tmpvar_49;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_50;
    tmpvar_50 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_50;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = colorBlendLightMap_12;
  tmpvar_51.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_51;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_21;
  mediump float tmpvar_22;
  mediump vec3 N_23;
  N_23 = xlv_TEXCOORD4;
  tmpvar_22 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_23)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_24;
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_19)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_32;
  mediump vec3 I_33;
  I_33 = -(I_11);
  tmpvar_32 = (I_33 - (2.0 * (
    dot (tmpvar_31, I_33)
   * tmpvar_31)));
  worldRef_6 = tmpvar_32;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_36;
  direction_36 = worldRef_6;
  highp vec3 position_37;
  position_37 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_38;
    tmpvar_38 = greaterThan (direction_36, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_39;
    if (tmpvar_38.x) {
      tmpvar_39 = tmpvar_35.x;
    } else {
      tmpvar_39 = tmpvar_34.x;
    };
    highp float tmpvar_40;
    if (tmpvar_38.y) {
      tmpvar_40 = tmpvar_35.y;
    } else {
      tmpvar_40 = tmpvar_34.y;
    };
    highp float tmpvar_41;
    if (tmpvar_38.z) {
      tmpvar_41 = tmpvar_35.z;
    } else {
      tmpvar_41 = tmpvar_34.z;
    };
    highp vec3 tmpvar_42;
    tmpvar_42.x = tmpvar_39;
    tmpvar_42.y = tmpvar_40;
    tmpvar_42.z = tmpvar_41;
    highp vec3 tmpvar_43;
    tmpvar_43 = ((tmpvar_42 - position_37) / direction_36);
    direction_36 = ((direction_36 * min (
      min (tmpvar_43.x, tmpvar_43.y)
    , tmpvar_43.z)) + (position_37 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_36;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = projectRef_5;
  tmpvar_44.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_46.w - 1.0)) + 1.0))
   * tmpvar_46.xyz) * tmpvar_26) * tmpvar_22);
  highp vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 0.0);
  tmpvar_47.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (tmpvar_47, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_49;
  tmpvar_49 = texture2D (_EmissionMask, tmpvar_48.xy).xyz;
  emissionTex_2 = tmpvar_49;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_50;
    tmpvar_50 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_50;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = colorBlendLightMap_12;
  tmpvar_51.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_51;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_21;
  mediump float tmpvar_22;
  mediump vec3 N_23;
  N_23 = xlv_TEXCOORD4;
  tmpvar_22 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_23)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_24;
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_19)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_32;
  mediump vec3 I_33;
  I_33 = -(I_11);
  tmpvar_32 = (I_33 - (2.0 * (
    dot (tmpvar_31, I_33)
   * tmpvar_31)));
  worldRef_6 = tmpvar_32;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_36;
  direction_36 = worldRef_6;
  highp vec3 position_37;
  position_37 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_38;
    tmpvar_38 = greaterThan (direction_36, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_39;
    if (tmpvar_38.x) {
      tmpvar_39 = tmpvar_35.x;
    } else {
      tmpvar_39 = tmpvar_34.x;
    };
    highp float tmpvar_40;
    if (tmpvar_38.y) {
      tmpvar_40 = tmpvar_35.y;
    } else {
      tmpvar_40 = tmpvar_34.y;
    };
    highp float tmpvar_41;
    if (tmpvar_38.z) {
      tmpvar_41 = tmpvar_35.z;
    } else {
      tmpvar_41 = tmpvar_34.z;
    };
    highp vec3 tmpvar_42;
    tmpvar_42.x = tmpvar_39;
    tmpvar_42.y = tmpvar_40;
    tmpvar_42.z = tmpvar_41;
    highp vec3 tmpvar_43;
    tmpvar_43 = ((tmpvar_42 - position_37) / direction_36);
    direction_36 = ((direction_36 * min (
      min (tmpvar_43.x, tmpvar_43.y)
    , tmpvar_43.z)) + (position_37 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_36;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = projectRef_5;
  tmpvar_44.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_46.w - 1.0)) + 1.0))
   * tmpvar_46.xyz) * tmpvar_26) * tmpvar_22);
  highp vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 0.0);
  tmpvar_47.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (tmpvar_47, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_49;
  tmpvar_49 = texture2D (_EmissionMask, tmpvar_48.xy).xyz;
  emissionTex_2 = tmpvar_49;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_50;
    tmpvar_50 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_50;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = colorBlendLightMap_12;
  tmpvar_51.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_51;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_21;
  mediump float tmpvar_22;
  mediump vec3 N_23;
  N_23 = xlv_TEXCOORD4;
  tmpvar_22 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_23)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_24;
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_19)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_32;
  mediump vec3 I_33;
  I_33 = -(I_11);
  tmpvar_32 = (I_33 - (2.0 * (
    dot (tmpvar_31, I_33)
   * tmpvar_31)));
  worldRef_6 = tmpvar_32;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_36;
  direction_36 = worldRef_6;
  highp vec3 position_37;
  position_37 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_38;
    tmpvar_38 = greaterThan (direction_36, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_39;
    if (tmpvar_38.x) {
      tmpvar_39 = tmpvar_35.x;
    } else {
      tmpvar_39 = tmpvar_34.x;
    };
    highp float tmpvar_40;
    if (tmpvar_38.y) {
      tmpvar_40 = tmpvar_35.y;
    } else {
      tmpvar_40 = tmpvar_34.y;
    };
    highp float tmpvar_41;
    if (tmpvar_38.z) {
      tmpvar_41 = tmpvar_35.z;
    } else {
      tmpvar_41 = tmpvar_34.z;
    };
    highp vec3 tmpvar_42;
    tmpvar_42.x = tmpvar_39;
    tmpvar_42.y = tmpvar_40;
    tmpvar_42.z = tmpvar_41;
    highp vec3 tmpvar_43;
    tmpvar_43 = ((tmpvar_42 - position_37) / direction_36);
    direction_36 = ((direction_36 * min (
      min (tmpvar_43.x, tmpvar_43.y)
    , tmpvar_43.z)) + (position_37 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_36;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = projectRef_5;
  tmpvar_44.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_46.w - 1.0)) + 1.0))
   * tmpvar_46.xyz) * tmpvar_26) * tmpvar_22);
  highp vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 0.0);
  tmpvar_47.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (tmpvar_47, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_49;
  tmpvar_49 = texture2D (_EmissionMask, tmpvar_48.xy).xyz;
  emissionTex_2 = tmpvar_49;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_50;
    tmpvar_50 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_50;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = colorBlendLightMap_12;
  tmpvar_51.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_51;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_14.w = tmpvar_15.w;
  lowp vec4 color_16;
  color_16 = tmpvar_15;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_16.xyz);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_17;
  highp vec2 screenCoord_18;
  screenCoord_18 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_19;
  shadow_19 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_18);
    shadow_19 = tmpvar_20.x;
  };
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_21;
  mediump float tmpvar_22;
  mediump vec3 N_23;
  N_23 = xlv_TEXCOORD4;
  tmpvar_22 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_23)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_24;
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_19)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_32;
  mediump vec3 I_33;
  I_33 = -(I_11);
  tmpvar_32 = (I_33 - (2.0 * (
    dot (tmpvar_31, I_33)
   * tmpvar_31)));
  worldRef_6 = tmpvar_32;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_36;
  direction_36 = worldRef_6;
  highp vec3 position_37;
  position_37 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_38;
    tmpvar_38 = greaterThan (direction_36, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_39;
    if (tmpvar_38.x) {
      tmpvar_39 = tmpvar_35.x;
    } else {
      tmpvar_39 = tmpvar_34.x;
    };
    highp float tmpvar_40;
    if (tmpvar_38.y) {
      tmpvar_40 = tmpvar_35.y;
    } else {
      tmpvar_40 = tmpvar_34.y;
    };
    highp float tmpvar_41;
    if (tmpvar_38.z) {
      tmpvar_41 = tmpvar_35.z;
    } else {
      tmpvar_41 = tmpvar_34.z;
    };
    highp vec3 tmpvar_42;
    tmpvar_42.x = tmpvar_39;
    tmpvar_42.y = tmpvar_40;
    tmpvar_42.z = tmpvar_41;
    highp vec3 tmpvar_43;
    tmpvar_43 = ((tmpvar_42 - position_37) / direction_36);
    direction_36 = ((direction_36 * min (
      min (tmpvar_43.x, tmpvar_43.y)
    , tmpvar_43.z)) + (position_37 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_36;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = projectRef_5;
  tmpvar_44.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_46.w - 1.0)) + 1.0))
   * tmpvar_46.xyz) * tmpvar_26) * tmpvar_22);
  highp vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 0.0);
  tmpvar_47.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (tmpvar_47, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_49;
  tmpvar_49 = texture2D (_EmissionMask, tmpvar_48.xy).xyz;
  emissionTex_2 = tmpvar_49;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_50;
    tmpvar_50 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_50;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = colorBlendLightMap_12;
  tmpvar_51.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_51;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_18)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_18)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_18)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_18)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_18)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_14 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_16;
  highp vec2 screenCoord_17;
  screenCoord_17 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_18;
  shadow_18 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_17);
    shadow_18 = tmpvar_19.x;
  };
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_20;
  mediump float tmpvar_21;
  mediump vec3 N_22;
  N_22 = xlv_TEXCOORD4;
  tmpvar_21 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_22)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_18)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_31;
  mediump vec3 I_32;
  I_32 = -(I_11);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (tmpvar_30, I_32)
   * tmpvar_30)));
  worldRef_6 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_35;
  direction_35 = worldRef_6;
  highp vec3 position_36;
  position_36 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_37;
    tmpvar_37 = greaterThan (direction_35, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_38;
    if (tmpvar_37.x) {
      tmpvar_38 = tmpvar_34.x;
    } else {
      tmpvar_38 = tmpvar_33.x;
    };
    highp float tmpvar_39;
    if (tmpvar_37.y) {
      tmpvar_39 = tmpvar_34.y;
    } else {
      tmpvar_39 = tmpvar_33.y;
    };
    highp float tmpvar_40;
    if (tmpvar_37.z) {
      tmpvar_40 = tmpvar_34.z;
    } else {
      tmpvar_40 = tmpvar_33.z;
    };
    highp vec3 tmpvar_41;
    tmpvar_41.x = tmpvar_38;
    tmpvar_41.y = tmpvar_39;
    tmpvar_41.z = tmpvar_40;
    highp vec3 tmpvar_42;
    tmpvar_42 = ((tmpvar_41 - position_36) / direction_35);
    direction_35 = ((direction_35 * min (
      min (tmpvar_42.x, tmpvar_42.y)
    , tmpvar_42.z)) + (position_36 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_35;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = projectRef_5;
  tmpvar_43.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_43.w);
  mediump vec4 tmpvar_45;
  tmpvar_45 = tmpvar_44;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_45.w - 1.0)) + 1.0))
   * tmpvar_45.xyz) * tmpvar_25) * tmpvar_21);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (tmpvar_46, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_48;
  tmpvar_48 = texture2D (_EmissionMask, tmpvar_47.xy).xyz;
  emissionTex_2 = tmpvar_48;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_49;
    tmpvar_49 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_49;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_50;
  tmpvar_50.xyz = colorBlendLightMap_12;
  tmpvar_50.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_50;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_23;
  mediump float tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  tmpvar_24 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_25)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_26;
  lowp float tmpvar_27;
  tmpvar_27 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_21)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_34;
  mediump vec3 I_35;
  I_35 = -(I_11);
  tmpvar_34 = (I_35 - (2.0 * (
    dot (tmpvar_33, I_35)
   * tmpvar_33)));
  worldRef_6 = tmpvar_34;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_38;
  direction_38 = worldRef_6;
  highp vec3 position_39;
  position_39 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_40;
    tmpvar_40 = greaterThan (direction_38, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_41;
    if (tmpvar_40.x) {
      tmpvar_41 = tmpvar_37.x;
    } else {
      tmpvar_41 = tmpvar_36.x;
    };
    highp float tmpvar_42;
    if (tmpvar_40.y) {
      tmpvar_42 = tmpvar_37.y;
    } else {
      tmpvar_42 = tmpvar_36.y;
    };
    highp float tmpvar_43;
    if (tmpvar_40.z) {
      tmpvar_43 = tmpvar_37.z;
    } else {
      tmpvar_43 = tmpvar_36.z;
    };
    highp vec3 tmpvar_44;
    tmpvar_44.x = tmpvar_41;
    tmpvar_44.y = tmpvar_42;
    tmpvar_44.z = tmpvar_43;
    highp vec3 tmpvar_45;
    tmpvar_45 = ((tmpvar_44 - position_39) / direction_38);
    direction_38 = ((direction_38 * min (
      min (tmpvar_45.x, tmpvar_45.y)
    , tmpvar_45.z)) + (position_39 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_38;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = projectRef_5;
  tmpvar_46.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_47;
  tmpvar_47 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_46.w);
  mediump vec4 tmpvar_48;
  tmpvar_48 = tmpvar_47;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_48.w - 1.0)) + 1.0))
   * tmpvar_48.xyz) * tmpvar_28) * tmpvar_24);
  highp vec4 tmpvar_49;
  tmpvar_49.zw = vec2(0.0, 0.0);
  tmpvar_49.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix (tmpvar_49, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_51;
  tmpvar_51 = texture2D (_EmissionMask, tmpvar_50.xy).xyz;
  emissionTex_2 = tmpvar_51;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_52;
    tmpvar_52 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_52;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = colorBlendLightMap_12;
  tmpvar_53.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_53;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_23;
  mediump float tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  tmpvar_24 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_25)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_26;
  lowp float tmpvar_27;
  tmpvar_27 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_21)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_34;
  mediump vec3 I_35;
  I_35 = -(I_11);
  tmpvar_34 = (I_35 - (2.0 * (
    dot (tmpvar_33, I_35)
   * tmpvar_33)));
  worldRef_6 = tmpvar_34;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_38;
  direction_38 = worldRef_6;
  highp vec3 position_39;
  position_39 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_40;
    tmpvar_40 = greaterThan (direction_38, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_41;
    if (tmpvar_40.x) {
      tmpvar_41 = tmpvar_37.x;
    } else {
      tmpvar_41 = tmpvar_36.x;
    };
    highp float tmpvar_42;
    if (tmpvar_40.y) {
      tmpvar_42 = tmpvar_37.y;
    } else {
      tmpvar_42 = tmpvar_36.y;
    };
    highp float tmpvar_43;
    if (tmpvar_40.z) {
      tmpvar_43 = tmpvar_37.z;
    } else {
      tmpvar_43 = tmpvar_36.z;
    };
    highp vec3 tmpvar_44;
    tmpvar_44.x = tmpvar_41;
    tmpvar_44.y = tmpvar_42;
    tmpvar_44.z = tmpvar_43;
    highp vec3 tmpvar_45;
    tmpvar_45 = ((tmpvar_44 - position_39) / direction_38);
    direction_38 = ((direction_38 * min (
      min (tmpvar_45.x, tmpvar_45.y)
    , tmpvar_45.z)) + (position_39 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_38;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = projectRef_5;
  tmpvar_46.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_47;
  tmpvar_47 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_46.w);
  mediump vec4 tmpvar_48;
  tmpvar_48 = tmpvar_47;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_48.w - 1.0)) + 1.0))
   * tmpvar_48.xyz) * tmpvar_28) * tmpvar_24);
  highp vec4 tmpvar_49;
  tmpvar_49.zw = vec2(0.0, 0.0);
  tmpvar_49.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix (tmpvar_49, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_51;
  tmpvar_51 = texture2D (_EmissionMask, tmpvar_50.xy).xyz;
  emissionTex_2 = tmpvar_51;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_52;
    tmpvar_52 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_52;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = colorBlendLightMap_12;
  tmpvar_53.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_53;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_23;
  mediump float tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  tmpvar_24 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_25)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_26;
  lowp float tmpvar_27;
  tmpvar_27 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_21)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_34;
  mediump vec3 I_35;
  I_35 = -(I_11);
  tmpvar_34 = (I_35 - (2.0 * (
    dot (tmpvar_33, I_35)
   * tmpvar_33)));
  worldRef_6 = tmpvar_34;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_38;
  direction_38 = worldRef_6;
  highp vec3 position_39;
  position_39 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_40;
    tmpvar_40 = greaterThan (direction_38, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_41;
    if (tmpvar_40.x) {
      tmpvar_41 = tmpvar_37.x;
    } else {
      tmpvar_41 = tmpvar_36.x;
    };
    highp float tmpvar_42;
    if (tmpvar_40.y) {
      tmpvar_42 = tmpvar_37.y;
    } else {
      tmpvar_42 = tmpvar_36.y;
    };
    highp float tmpvar_43;
    if (tmpvar_40.z) {
      tmpvar_43 = tmpvar_37.z;
    } else {
      tmpvar_43 = tmpvar_36.z;
    };
    highp vec3 tmpvar_44;
    tmpvar_44.x = tmpvar_41;
    tmpvar_44.y = tmpvar_42;
    tmpvar_44.z = tmpvar_43;
    highp vec3 tmpvar_45;
    tmpvar_45 = ((tmpvar_44 - position_39) / direction_38);
    direction_38 = ((direction_38 * min (
      min (tmpvar_45.x, tmpvar_45.y)
    , tmpvar_45.z)) + (position_39 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_38;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = projectRef_5;
  tmpvar_46.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_47;
  tmpvar_47 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_46.w);
  mediump vec4 tmpvar_48;
  tmpvar_48 = tmpvar_47;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_48.w - 1.0)) + 1.0))
   * tmpvar_48.xyz) * tmpvar_28) * tmpvar_24);
  highp vec4 tmpvar_49;
  tmpvar_49.zw = vec2(0.0, 0.0);
  tmpvar_49.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix (tmpvar_49, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_51;
  tmpvar_51 = texture2D (_EmissionMask, tmpvar_50.xy).xyz;
  emissionTex_2 = tmpvar_51;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_52;
    tmpvar_52 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_52;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = colorBlendLightMap_12;
  tmpvar_53.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_53;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_23;
  mediump float tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  tmpvar_24 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_25)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_26;
  lowp float tmpvar_27;
  tmpvar_27 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_21)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_34;
  mediump vec3 I_35;
  I_35 = -(I_11);
  tmpvar_34 = (I_35 - (2.0 * (
    dot (tmpvar_33, I_35)
   * tmpvar_33)));
  worldRef_6 = tmpvar_34;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_38;
  direction_38 = worldRef_6;
  highp vec3 position_39;
  position_39 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_40;
    tmpvar_40 = greaterThan (direction_38, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_41;
    if (tmpvar_40.x) {
      tmpvar_41 = tmpvar_37.x;
    } else {
      tmpvar_41 = tmpvar_36.x;
    };
    highp float tmpvar_42;
    if (tmpvar_40.y) {
      tmpvar_42 = tmpvar_37.y;
    } else {
      tmpvar_42 = tmpvar_36.y;
    };
    highp float tmpvar_43;
    if (tmpvar_40.z) {
      tmpvar_43 = tmpvar_37.z;
    } else {
      tmpvar_43 = tmpvar_36.z;
    };
    highp vec3 tmpvar_44;
    tmpvar_44.x = tmpvar_41;
    tmpvar_44.y = tmpvar_42;
    tmpvar_44.z = tmpvar_43;
    highp vec3 tmpvar_45;
    tmpvar_45 = ((tmpvar_44 - position_39) / direction_38);
    direction_38 = ((direction_38 * min (
      min (tmpvar_45.x, tmpvar_45.y)
    , tmpvar_45.z)) + (position_39 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_38;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = projectRef_5;
  tmpvar_46.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_47;
  tmpvar_47 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_46.w);
  mediump vec4 tmpvar_48;
  tmpvar_48 = tmpvar_47;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_48.w - 1.0)) + 1.0))
   * tmpvar_48.xyz) * tmpvar_28) * tmpvar_24);
  highp vec4 tmpvar_49;
  tmpvar_49.zw = vec2(0.0, 0.0);
  tmpvar_49.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix (tmpvar_49, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_51;
  tmpvar_51 = texture2D (_EmissionMask, tmpvar_50.xy).xyz;
  emissionTex_2 = tmpvar_51;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_52;
    tmpvar_52 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_52;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = colorBlendLightMap_12;
  tmpvar_53.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_53;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_23;
  mediump float tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  tmpvar_24 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_25)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_26;
  lowp float tmpvar_27;
  tmpvar_27 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_21)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_34;
  mediump vec3 I_35;
  I_35 = -(I_11);
  tmpvar_34 = (I_35 - (2.0 * (
    dot (tmpvar_33, I_35)
   * tmpvar_33)));
  worldRef_6 = tmpvar_34;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_38;
  direction_38 = worldRef_6;
  highp vec3 position_39;
  position_39 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_40;
    tmpvar_40 = greaterThan (direction_38, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_41;
    if (tmpvar_40.x) {
      tmpvar_41 = tmpvar_37.x;
    } else {
      tmpvar_41 = tmpvar_36.x;
    };
    highp float tmpvar_42;
    if (tmpvar_40.y) {
      tmpvar_42 = tmpvar_37.y;
    } else {
      tmpvar_42 = tmpvar_36.y;
    };
    highp float tmpvar_43;
    if (tmpvar_40.z) {
      tmpvar_43 = tmpvar_37.z;
    } else {
      tmpvar_43 = tmpvar_36.z;
    };
    highp vec3 tmpvar_44;
    tmpvar_44.x = tmpvar_41;
    tmpvar_44.y = tmpvar_42;
    tmpvar_44.z = tmpvar_43;
    highp vec3 tmpvar_45;
    tmpvar_45 = ((tmpvar_44 - position_39) / direction_38);
    direction_38 = ((direction_38 * min (
      min (tmpvar_45.x, tmpvar_45.y)
    , tmpvar_45.z)) + (position_39 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_38;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = projectRef_5;
  tmpvar_46.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_47;
  tmpvar_47 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_46.w);
  mediump vec4 tmpvar_48;
  tmpvar_48 = tmpvar_47;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_48.w - 1.0)) + 1.0))
   * tmpvar_48.xyz) * tmpvar_28) * tmpvar_24);
  highp vec4 tmpvar_49;
  tmpvar_49.zw = vec2(0.0, 0.0);
  tmpvar_49.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix (tmpvar_49, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_51;
  tmpvar_51 = texture2D (_EmissionMask, tmpvar_50.xy).xyz;
  emissionTex_2 = tmpvar_51;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_52;
    tmpvar_52 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_52;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = colorBlendLightMap_12;
  tmpvar_53.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_53;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_14.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_23;
  mediump float tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD4;
  tmpvar_24 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_25)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_26;
  lowp float tmpvar_27;
  tmpvar_27 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_21)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_34;
  mediump vec3 I_35;
  I_35 = -(I_11);
  tmpvar_34 = (I_35 - (2.0 * (
    dot (tmpvar_33, I_35)
   * tmpvar_33)));
  worldRef_6 = tmpvar_34;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_38;
  direction_38 = worldRef_6;
  highp vec3 position_39;
  position_39 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_40;
    tmpvar_40 = greaterThan (direction_38, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_41;
    if (tmpvar_40.x) {
      tmpvar_41 = tmpvar_37.x;
    } else {
      tmpvar_41 = tmpvar_36.x;
    };
    highp float tmpvar_42;
    if (tmpvar_40.y) {
      tmpvar_42 = tmpvar_37.y;
    } else {
      tmpvar_42 = tmpvar_36.y;
    };
    highp float tmpvar_43;
    if (tmpvar_40.z) {
      tmpvar_43 = tmpvar_37.z;
    } else {
      tmpvar_43 = tmpvar_36.z;
    };
    highp vec3 tmpvar_44;
    tmpvar_44.x = tmpvar_41;
    tmpvar_44.y = tmpvar_42;
    tmpvar_44.z = tmpvar_43;
    highp vec3 tmpvar_45;
    tmpvar_45 = ((tmpvar_44 - position_39) / direction_38);
    direction_38 = ((direction_38 * min (
      min (tmpvar_45.x, tmpvar_45.y)
    , tmpvar_45.z)) + (position_39 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_38;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = projectRef_5;
  tmpvar_46.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_47;
  tmpvar_47 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_46.w);
  mediump vec4 tmpvar_48;
  tmpvar_48 = tmpvar_47;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_48.w - 1.0)) + 1.0))
   * tmpvar_48.xyz) * tmpvar_28) * tmpvar_24);
  highp vec4 tmpvar_49;
  tmpvar_49.zw = vec2(0.0, 0.0);
  tmpvar_49.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_50;
  tmpvar_50 = mix (tmpvar_49, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_51;
  tmpvar_51 = texture2D (_EmissionMask, tmpvar_50.xy).xyz;
  emissionTex_2 = tmpvar_51;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_52;
    tmpvar_52 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_52;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = colorBlendLightMap_12;
  tmpvar_53.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_53;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_22;
  mediump float tmpvar_23;
  mediump vec3 N_24;
  N_24 = xlv_TEXCOORD4;
  tmpvar_23 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_24)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_25;
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_20)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_31;
  highp vec3 tmpvar_32;
  tmpvar_32 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(I_11);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_32, I_34)
   * tmpvar_32)));
  worldRef_6 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_37;
  direction_37 = worldRef_6;
  highp vec3 position_38;
  position_38 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_39;
    tmpvar_39 = greaterThan (direction_37, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_40;
    if (tmpvar_39.x) {
      tmpvar_40 = tmpvar_36.x;
    } else {
      tmpvar_40 = tmpvar_35.x;
    };
    highp float tmpvar_41;
    if (tmpvar_39.y) {
      tmpvar_41 = tmpvar_36.y;
    } else {
      tmpvar_41 = tmpvar_35.y;
    };
    highp float tmpvar_42;
    if (tmpvar_39.z) {
      tmpvar_42 = tmpvar_36.z;
    } else {
      tmpvar_42 = tmpvar_35.z;
    };
    highp vec3 tmpvar_43;
    tmpvar_43.x = tmpvar_40;
    tmpvar_43.y = tmpvar_41;
    tmpvar_43.z = tmpvar_42;
    highp vec3 tmpvar_44;
    tmpvar_44 = ((tmpvar_43 - position_38) / direction_37);
    direction_37 = ((direction_37 * min (
      min (tmpvar_44.x, tmpvar_44.y)
    , tmpvar_44.z)) + (position_38 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_37;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = projectRef_5;
  tmpvar_45.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_46;
  tmpvar_46 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_45.w);
  mediump vec4 tmpvar_47;
  tmpvar_47 = tmpvar_46;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_47.w - 1.0)) + 1.0))
   * tmpvar_47.xyz) * tmpvar_27) * tmpvar_23);
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_48, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_50;
  tmpvar_50 = texture2D (_EmissionMask, tmpvar_49.xy).xyz;
  emissionTex_2 = tmpvar_50;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_51;
    tmpvar_51 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_51;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = colorBlendLightMap_12;
  tmpvar_52.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_52;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_22;
  mediump float tmpvar_23;
  mediump vec3 N_24;
  N_24 = xlv_TEXCOORD4;
  tmpvar_23 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_24)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_25;
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_20)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_31;
  highp vec3 tmpvar_32;
  tmpvar_32 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(I_11);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_32, I_34)
   * tmpvar_32)));
  worldRef_6 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_37;
  direction_37 = worldRef_6;
  highp vec3 position_38;
  position_38 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_39;
    tmpvar_39 = greaterThan (direction_37, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_40;
    if (tmpvar_39.x) {
      tmpvar_40 = tmpvar_36.x;
    } else {
      tmpvar_40 = tmpvar_35.x;
    };
    highp float tmpvar_41;
    if (tmpvar_39.y) {
      tmpvar_41 = tmpvar_36.y;
    } else {
      tmpvar_41 = tmpvar_35.y;
    };
    highp float tmpvar_42;
    if (tmpvar_39.z) {
      tmpvar_42 = tmpvar_36.z;
    } else {
      tmpvar_42 = tmpvar_35.z;
    };
    highp vec3 tmpvar_43;
    tmpvar_43.x = tmpvar_40;
    tmpvar_43.y = tmpvar_41;
    tmpvar_43.z = tmpvar_42;
    highp vec3 tmpvar_44;
    tmpvar_44 = ((tmpvar_43 - position_38) / direction_37);
    direction_37 = ((direction_37 * min (
      min (tmpvar_44.x, tmpvar_44.y)
    , tmpvar_44.z)) + (position_38 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_37;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = projectRef_5;
  tmpvar_45.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_46;
  tmpvar_46 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_45.w);
  mediump vec4 tmpvar_47;
  tmpvar_47 = tmpvar_46;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_47.w - 1.0)) + 1.0))
   * tmpvar_47.xyz) * tmpvar_27) * tmpvar_23);
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_48, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_50;
  tmpvar_50 = texture2D (_EmissionMask, tmpvar_49.xy).xyz;
  emissionTex_2 = tmpvar_50;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_51;
    tmpvar_51 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_51;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = colorBlendLightMap_12;
  tmpvar_52.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_52;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_22;
  mediump float tmpvar_23;
  mediump vec3 N_24;
  N_24 = xlv_TEXCOORD4;
  tmpvar_23 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_24)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_25;
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_20)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_31;
  highp vec3 tmpvar_32;
  tmpvar_32 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(I_11);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_32, I_34)
   * tmpvar_32)));
  worldRef_6 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_37;
  direction_37 = worldRef_6;
  highp vec3 position_38;
  position_38 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_39;
    tmpvar_39 = greaterThan (direction_37, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_40;
    if (tmpvar_39.x) {
      tmpvar_40 = tmpvar_36.x;
    } else {
      tmpvar_40 = tmpvar_35.x;
    };
    highp float tmpvar_41;
    if (tmpvar_39.y) {
      tmpvar_41 = tmpvar_36.y;
    } else {
      tmpvar_41 = tmpvar_35.y;
    };
    highp float tmpvar_42;
    if (tmpvar_39.z) {
      tmpvar_42 = tmpvar_36.z;
    } else {
      tmpvar_42 = tmpvar_35.z;
    };
    highp vec3 tmpvar_43;
    tmpvar_43.x = tmpvar_40;
    tmpvar_43.y = tmpvar_41;
    tmpvar_43.z = tmpvar_42;
    highp vec3 tmpvar_44;
    tmpvar_44 = ((tmpvar_43 - position_38) / direction_37);
    direction_37 = ((direction_37 * min (
      min (tmpvar_44.x, tmpvar_44.y)
    , tmpvar_44.z)) + (position_38 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_37;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = projectRef_5;
  tmpvar_45.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_46;
  tmpvar_46 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_45.w);
  mediump vec4 tmpvar_47;
  tmpvar_47 = tmpvar_46;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_47.w - 1.0)) + 1.0))
   * tmpvar_47.xyz) * tmpvar_27) * tmpvar_23);
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_48, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_50;
  tmpvar_50 = texture2D (_EmissionMask, tmpvar_49.xy).xyz;
  emissionTex_2 = tmpvar_50;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_51;
    tmpvar_51 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_51;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = colorBlendLightMap_12;
  tmpvar_52.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_52;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_22;
  mediump float tmpvar_23;
  mediump vec3 N_24;
  N_24 = xlv_TEXCOORD4;
  tmpvar_23 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_24)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_25;
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_20)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_31;
  highp vec3 tmpvar_32;
  tmpvar_32 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(I_11);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_32, I_34)
   * tmpvar_32)));
  worldRef_6 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_37;
  direction_37 = worldRef_6;
  highp vec3 position_38;
  position_38 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_39;
    tmpvar_39 = greaterThan (direction_37, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_40;
    if (tmpvar_39.x) {
      tmpvar_40 = tmpvar_36.x;
    } else {
      tmpvar_40 = tmpvar_35.x;
    };
    highp float tmpvar_41;
    if (tmpvar_39.y) {
      tmpvar_41 = tmpvar_36.y;
    } else {
      tmpvar_41 = tmpvar_35.y;
    };
    highp float tmpvar_42;
    if (tmpvar_39.z) {
      tmpvar_42 = tmpvar_36.z;
    } else {
      tmpvar_42 = tmpvar_35.z;
    };
    highp vec3 tmpvar_43;
    tmpvar_43.x = tmpvar_40;
    tmpvar_43.y = tmpvar_41;
    tmpvar_43.z = tmpvar_42;
    highp vec3 tmpvar_44;
    tmpvar_44 = ((tmpvar_43 - position_38) / direction_37);
    direction_37 = ((direction_37 * min (
      min (tmpvar_44.x, tmpvar_44.y)
    , tmpvar_44.z)) + (position_38 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_37;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = projectRef_5;
  tmpvar_45.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_46;
  tmpvar_46 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_45.w);
  mediump vec4 tmpvar_47;
  tmpvar_47 = tmpvar_46;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_47.w - 1.0)) + 1.0))
   * tmpvar_47.xyz) * tmpvar_27) * tmpvar_23);
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_48, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_50;
  tmpvar_50 = texture2D (_EmissionMask, tmpvar_49.xy).xyz;
  emissionTex_2 = tmpvar_50;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_51;
    tmpvar_51 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_51;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = colorBlendLightMap_12;
  tmpvar_52.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_52;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_22;
  mediump float tmpvar_23;
  mediump vec3 N_24;
  N_24 = xlv_TEXCOORD4;
  tmpvar_23 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_24)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_25;
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_20)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_31;
  highp vec3 tmpvar_32;
  tmpvar_32 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(I_11);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_32, I_34)
   * tmpvar_32)));
  worldRef_6 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_37;
  direction_37 = worldRef_6;
  highp vec3 position_38;
  position_38 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_39;
    tmpvar_39 = greaterThan (direction_37, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_40;
    if (tmpvar_39.x) {
      tmpvar_40 = tmpvar_36.x;
    } else {
      tmpvar_40 = tmpvar_35.x;
    };
    highp float tmpvar_41;
    if (tmpvar_39.y) {
      tmpvar_41 = tmpvar_36.y;
    } else {
      tmpvar_41 = tmpvar_35.y;
    };
    highp float tmpvar_42;
    if (tmpvar_39.z) {
      tmpvar_42 = tmpvar_36.z;
    } else {
      tmpvar_42 = tmpvar_35.z;
    };
    highp vec3 tmpvar_43;
    tmpvar_43.x = tmpvar_40;
    tmpvar_43.y = tmpvar_41;
    tmpvar_43.z = tmpvar_42;
    highp vec3 tmpvar_44;
    tmpvar_44 = ((tmpvar_43 - position_38) / direction_37);
    direction_37 = ((direction_37 * min (
      min (tmpvar_44.x, tmpvar_44.y)
    , tmpvar_44.z)) + (position_38 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_37;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = projectRef_5;
  tmpvar_45.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_46;
  tmpvar_46 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_45.w);
  mediump vec4 tmpvar_47;
  tmpvar_47 = tmpvar_46;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_47.w - 1.0)) + 1.0))
   * tmpvar_47.xyz) * tmpvar_27) * tmpvar_23);
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_48, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_50;
  tmpvar_50 = texture2D (_EmissionMask, tmpvar_49.xy).xyz;
  emissionTex_2 = tmpvar_50;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_51;
    tmpvar_51 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_51;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = colorBlendLightMap_12;
  tmpvar_52.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_52;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform lowp samplerCube unity_SpecCube0;
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform sampler2D _ReflectMaskTex;
uniform mediump vec4 _ReflectionAdjust;
uniform mediump vec4 _FresnelParams;
uniform highp float _BrushScale;
uniform highp float _Smoothness;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 reflColor_3;
  mediump float tmpvar_4;
  mediump vec3 projectRef_5;
  mediump vec3 worldRef_6;
  highp vec3 worldbrushed_7;
  mediump vec3 brushedValue_8;
  mediump float reflectG_9;
  mediump float reflectR_10;
  mediump vec3 I_11;
  mediump vec3 colorBlendLightMap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 lmtex_14;
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
  lmtex_14 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_13 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_11 = tmpvar_22;
  mediump float tmpvar_23;
  mediump vec3 N_24;
  N_24 = xlv_TEXCOORD4;
  tmpvar_23 = (_FresnelParams.z + max (0.0, (
    pow (clamp ((1.0 - dot (I_11, N_24)), 0.001, 1.0), _FresnelParams.x)
   * _FresnelParams.y)));
  lowp float tmpvar_25;
  tmpvar_25 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.xy).x;
  reflectR_10 = tmpvar_25;
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ReflectMaskTex, xlv_TEXCOORD1.zw).y;
  reflectG_9 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp (((reflectR_10 * _ReflectionAdjust.x) + (reflectG_9 * _ReflectionAdjust.y)), 0.0, 1.0);
  colorBlendLightMap_12 = (((tex_C_Color_13.xyz * _Color.xyz) * (
    (((lmtex_14.xyz * _ShadowColor) * (1.0 - (
      clamp ((lmtex_14.x - _ShadowIntegration), 0.0, 1.0)
     * 
      (1.0 - shadow_20)
    ))) * _LightMapIntensity)
   + _LightingColor)) * clamp ((1.0 - 
    ((reflectR_10 * _ReflectionAdjust.z) + (reflectG_9 * _ReflectionAdjust.w))
  ), 0.0, 1.0));
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_BrushedNormalMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  brushedValue_8 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD6, brushedValue_8);
  worldbrushed_7.x = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD7, brushedValue_8);
  worldbrushed_7.y = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = dot (xlv_TEXCOORD8, brushedValue_8);
  worldbrushed_7.z = tmpvar_31;
  highp vec3 tmpvar_32;
  tmpvar_32 = mix (xlv_TEXCOORD4, worldbrushed_7, vec3(_BrushScale));
  highp vec3 tmpvar_33;
  mediump vec3 I_34;
  I_34 = -(I_11);
  tmpvar_33 = (I_34 - (2.0 * (
    dot (tmpvar_32, I_34)
   * tmpvar_32)));
  worldRef_6 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = unity_SpecCube0_BoxMin.xyz;
  highp vec3 tmpvar_36;
  tmpvar_36 = unity_SpecCube0_BoxMax.xyz;
  highp vec3 direction_37;
  direction_37 = worldRef_6;
  highp vec3 position_38;
  position_38 = xlv_TEXCOORD5;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    bvec3 tmpvar_39;
    tmpvar_39 = greaterThan (direction_37, vec3(0.0, 0.0, 0.0));
    highp float tmpvar_40;
    if (tmpvar_39.x) {
      tmpvar_40 = tmpvar_36.x;
    } else {
      tmpvar_40 = tmpvar_35.x;
    };
    highp float tmpvar_41;
    if (tmpvar_39.y) {
      tmpvar_41 = tmpvar_36.y;
    } else {
      tmpvar_41 = tmpvar_35.y;
    };
    highp float tmpvar_42;
    if (tmpvar_39.z) {
      tmpvar_42 = tmpvar_36.z;
    } else {
      tmpvar_42 = tmpvar_35.z;
    };
    highp vec3 tmpvar_43;
    tmpvar_43.x = tmpvar_40;
    tmpvar_43.y = tmpvar_41;
    tmpvar_43.z = tmpvar_42;
    highp vec3 tmpvar_44;
    tmpvar_44 = ((tmpvar_43 - position_38) / direction_37);
    direction_37 = ((direction_37 * min (
      min (tmpvar_44.x, tmpvar_44.y)
    , tmpvar_44.z)) + (position_38 - unity_SpecCube0_ProbePosition.xyz));
  };
  projectRef_5 = direction_37;
  tmpvar_4 = (1.0 - _Smoothness);
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = projectRef_5;
  tmpvar_45.w = ((tmpvar_4 * (1.7 - 
    (0.7 * tmpvar_4)
  )) * 6.0);
  lowp vec4 tmpvar_46;
  tmpvar_46 = impl_low_textureCubeLodEXT (unity_SpecCube0, projectRef_5, tmpvar_45.w);
  mediump vec4 tmpvar_47;
  tmpvar_47 = tmpvar_46;
  reflColor_3 = (((
    (unity_SpecCube0_HDR.x * ((unity_SpecCube0_HDR.w * (tmpvar_47.w - 1.0)) + 1.0))
   * tmpvar_47.xyz) * tmpvar_27) * tmpvar_23);
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_48, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_50;
  tmpvar_50 = texture2D (_EmissionMask, tmpvar_49.xy).xyz;
  emissionTex_2 = tmpvar_50;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_51;
    tmpvar_51 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_51;
  };
  colorBlendLightMap_12 = ((colorBlendLightMap_12 + reflColor_3) + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_12 = mix (colorBlendLightMap_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = colorBlendLightMap_12;
  tmpvar_52.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_52;
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
 UsePass "Hidden/miHoYo/DLC/Common/Meta/META"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 87130
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (tmpvar_10, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11.xy).xyz;
  emissionTex_2 = tmpvar_12;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_13;
    tmpvar_13 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_13;
  };
  colorBlendLightMap_3 = (tmpvar_9 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = colorBlendLightMap_3;
  tmpvar_14.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_14;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (tmpvar_10, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11.xy).xyz;
  emissionTex_2 = tmpvar_12;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_13;
    tmpvar_13 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_13;
  };
  colorBlendLightMap_3 = (tmpvar_9 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = colorBlendLightMap_3;
  tmpvar_14.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_14;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (tmpvar_10, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11.xy).xyz;
  emissionTex_2 = tmpvar_12;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_13;
    tmpvar_13 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_13;
  };
  colorBlendLightMap_3 = (tmpvar_9 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = colorBlendLightMap_3;
  tmpvar_14.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_14;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (tmpvar_10, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11.xy).xyz;
  emissionTex_2 = tmpvar_12;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_13;
    tmpvar_13 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_13;
  };
  colorBlendLightMap_3 = (tmpvar_9 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = colorBlendLightMap_3;
  tmpvar_14.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_14;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (tmpvar_10, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11.xy).xyz;
  emissionTex_2 = tmpvar_12;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_13;
    tmpvar_13 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_13;
  };
  colorBlendLightMap_3 = (tmpvar_9 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = colorBlendLightMap_3;
  tmpvar_14.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_14;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (tmpvar_10, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11.xy).xyz;
  emissionTex_2 = tmpvar_12;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_13;
    tmpvar_13 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_13;
  };
  colorBlendLightMap_3 = (tmpvar_9 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = colorBlendLightMap_3;
  tmpvar_14.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_14;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_9, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_EmissionMask, tmpvar_10.xy).xyz;
  emissionTex_2 = tmpvar_11;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_12;
    tmpvar_12 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_12;
  };
  colorBlendLightMap_3 = (tmpvar_8 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_3;
  tmpvar_13.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_13;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_9, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_EmissionMask, tmpvar_10.xy).xyz;
  emissionTex_2 = tmpvar_11;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_12;
    tmpvar_12 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_12;
  };
  colorBlendLightMap_3 = (tmpvar_8 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_3;
  tmpvar_13.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_13;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_9, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_EmissionMask, tmpvar_10.xy).xyz;
  emissionTex_2 = tmpvar_11;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_12;
    tmpvar_12 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_12;
  };
  colorBlendLightMap_3 = (tmpvar_8 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_3;
  tmpvar_13.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_13;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_9, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_EmissionMask, tmpvar_10.xy).xyz;
  emissionTex_2 = tmpvar_11;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_12;
    tmpvar_12 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_12;
  };
  colorBlendLightMap_3 = (tmpvar_8 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_3;
  tmpvar_13.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_13;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_9, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_EmissionMask, tmpvar_10.xy).xyz;
  emissionTex_2 = tmpvar_11;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_12;
    tmpvar_12 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_12;
  };
  colorBlendLightMap_3 = (tmpvar_8 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_3;
  tmpvar_13.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_13;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    (lmtex_5.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_9, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_EmissionMask, tmpvar_10.xy).xyz;
  emissionTex_2 = tmpvar_11;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_12;
    tmpvar_12 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_12;
  };
  colorBlendLightMap_3 = (tmpvar_8 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = colorBlendLightMap_3;
  tmpvar_13.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_13;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  highp vec2 screenCoord_9;
  screenCoord_9 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_10;
  shadow_10 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_11;
    tmpvar_11 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_9);
    shadow_10 = tmpvar_11.x;
  };
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_10))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (tmpvar_13, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_EmissionMask, tmpvar_14.xy).xyz;
  emissionTex_2 = tmpvar_15;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_16;
    tmpvar_16 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_16;
  };
  colorBlendLightMap_3 = (tmpvar_12 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_3;
  tmpvar_17.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  highp vec2 screenCoord_9;
  screenCoord_9 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_10;
  shadow_10 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_11;
    tmpvar_11 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_9);
    shadow_10 = tmpvar_11.x;
  };
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_10))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (tmpvar_13, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_EmissionMask, tmpvar_14.xy).xyz;
  emissionTex_2 = tmpvar_15;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_16;
    tmpvar_16 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_16;
  };
  colorBlendLightMap_3 = (tmpvar_12 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_3;
  tmpvar_17.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  highp vec2 screenCoord_9;
  screenCoord_9 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_10;
  shadow_10 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_11;
    tmpvar_11 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_9);
    shadow_10 = tmpvar_11.x;
  };
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_10))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (tmpvar_13, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_EmissionMask, tmpvar_14.xy).xyz;
  emissionTex_2 = tmpvar_15;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_16;
    tmpvar_16 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_16;
  };
  colorBlendLightMap_3 = (tmpvar_12 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_3;
  tmpvar_17.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  highp vec2 screenCoord_9;
  screenCoord_9 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_10;
  shadow_10 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_11;
    tmpvar_11 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_9);
    shadow_10 = tmpvar_11.x;
  };
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_10))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (tmpvar_13, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_EmissionMask, tmpvar_14.xy).xyz;
  emissionTex_2 = tmpvar_15;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_16;
    tmpvar_16 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_16;
  };
  colorBlendLightMap_3 = (tmpvar_12 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_3;
  tmpvar_17.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  highp vec2 screenCoord_9;
  screenCoord_9 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_10;
  shadow_10 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_11;
    tmpvar_11 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_9);
    shadow_10 = tmpvar_11.x;
  };
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_10))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (tmpvar_13, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_EmissionMask, tmpvar_14.xy).xyz;
  emissionTex_2 = tmpvar_15;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_16;
    tmpvar_16 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_16;
  };
  colorBlendLightMap_3 = (tmpvar_12 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_3;
  tmpvar_17.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_5.w = tmpvar_6.w;
  lowp vec4 color_7;
  color_7 = tmpvar_6;
  lmtex_5.xyz = (unity_Lightmap_HDR.x * color_7.xyz);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_8;
  highp vec2 screenCoord_9;
  screenCoord_9 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_10;
  shadow_10 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_11;
    tmpvar_11 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_9);
    shadow_10 = tmpvar_11.x;
  };
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_10))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (tmpvar_13, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_EmissionMask, tmpvar_14.xy).xyz;
  emissionTex_2 = tmpvar_15;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_16;
    tmpvar_16 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_16;
  };
  colorBlendLightMap_3 = (tmpvar_12 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = colorBlendLightMap_3;
  tmpvar_17.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_9))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (tmpvar_12, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13.xy).xyz;
  emissionTex_2 = tmpvar_14;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_15;
    tmpvar_15 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_15;
  };
  colorBlendLightMap_3 = (tmpvar_11 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_3;
  tmpvar_16.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_9))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (tmpvar_12, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13.xy).xyz;
  emissionTex_2 = tmpvar_14;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_15;
    tmpvar_15 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_15;
  };
  colorBlendLightMap_3 = (tmpvar_11 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_3;
  tmpvar_16.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_9))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (tmpvar_12, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13.xy).xyz;
  emissionTex_2 = tmpvar_14;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_15;
    tmpvar_15 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_15;
  };
  colorBlendLightMap_3 = (tmpvar_11 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_3;
  tmpvar_16.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_9))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (tmpvar_12, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13.xy).xyz;
  emissionTex_2 = tmpvar_14;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_15;
    tmpvar_15 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_15;
  };
  colorBlendLightMap_3 = (tmpvar_11 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_3;
  tmpvar_16.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_9))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (tmpvar_12, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13.xy).xyz;
  emissionTex_2 = tmpvar_14;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_15;
    tmpvar_15 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_15;
  };
  colorBlendLightMap_3 = (tmpvar_11 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_3;
  tmpvar_16.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
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
uniform highp vec4 _BrushedNormalMap_ST;
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
varying mediump vec3 xlv_TEXCOORD8;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  mediump vec3 worldTangent_3;
  mediump vec3 worldNormal_4;
  highp vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6.zw = _glesMultiTexCoord1.xy;
  highp vec3 norm_11;
  norm_11 = tmpvar_1;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((norm_11 * tmpvar_12));
  worldNormal_4 = tmpvar_13;
  highp vec3 dir_14;
  dir_14 = tmpvar_2.xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * dir_14));
  worldTangent_3 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * _glesTANGENT.w);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_3.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = worldNormal_4.x;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_3.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = worldNormal_4.y;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_3.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = worldNormal_4.z;
  tmpvar_7 = worldNormal_4;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_8 = tmpvar_24;
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD3 = o_21;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_18;
  xlv_TEXCOORD7 = tmpvar_19;
  xlv_TEXCOORD8 = tmpvar_20;
  xlv_COLOR1 = tmpvar_26;
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
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float emissionMask_1;
  mediump vec3 emissionTex_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 lmtex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_4 = tmpvar_7;
  highp vec2 screenCoord_8;
  screenCoord_8 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_9;
  shadow_9 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_8);
    shadow_9 = tmpvar_10.x;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * ((
    ((lmtex_5.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_5.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_9))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = xlv_TEXCOORD0.xy;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (tmpvar_12, xlv_TEXCOORD1, vec4(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13.xy).xyz;
  emissionTex_2 = tmpvar_14;
  emissionMask_1 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_1 = emissionTex_2.z;
  } else {
    highp float tmpvar_15;
    tmpvar_15 = mix (emissionTex_2.x, emissionTex_2.y, float(_UseChannel));
    emissionMask_1 = tmpvar_15;
  };
  colorBlendLightMap_3 = (tmpvar_11 + ((emissionMask_1 * _Emission.xyz) * (_Emission.w * 2.0)));
  colorBlendLightMap_3 = mix (colorBlendLightMap_3, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = colorBlendLightMap_3;
  tmpvar_16.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_16;
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
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Meta/META"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}