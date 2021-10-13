//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Scene_Air_LightMap_Matcap" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
[MHYHeaderBox(MATCAP)] _MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
[MHYHeaderBox(Fresnel)] _fresnelColA ("FresnelCol", Color) = (1,1,1,1)
_fresnelBaseA ("FresnelBase", Range(0, 4)) = 0
_fresnelScaleA ("FresnelScale", Range(0, 4)) = 0
_fresnelIndensity ("FresnelIndensity", Range(0, 5)) = 5
[MHYHeaderBox(FOG)] _FogTune ("Fog Tune", Range(0, 1)) = 1
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 45547
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_1 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = _BloomFactor;
  gl_FragData[0] = tmpvar_22;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_1 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = _BloomFactor;
  gl_FragData[0] = tmpvar_22;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_1 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = _BloomFactor;
  gl_FragData[0] = tmpvar_22;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_1 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = _BloomFactor;
  gl_FragData[0] = tmpvar_22;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_1 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = _BloomFactor;
  gl_FragData[0] = tmpvar_22;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_1 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = _BloomFactor;
  gl_FragData[0] = tmpvar_22;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, vec3(dot (tmpvar_21, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22;
  tmpvar_23.w = _BloomFactor;
  gl_FragData[0] = tmpvar_23;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, vec3(dot (tmpvar_21, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22;
  tmpvar_23.w = _BloomFactor;
  gl_FragData[0] = tmpvar_23;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, vec3(dot (tmpvar_21, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22;
  tmpvar_23.w = _BloomFactor;
  gl_FragData[0] = tmpvar_23;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, vec3(dot (tmpvar_21, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22;
  tmpvar_23.w = _BloomFactor;
  gl_FragData[0] = tmpvar_23;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, vec3(dot (tmpvar_21, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22;
  tmpvar_23.w = _BloomFactor;
  gl_FragData[0] = tmpvar_23;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  mediump vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = (_glesNormal * tmpvar_13);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (tmpvar_14.xyz * _WorldSpaceLightPos0.w));
  tmpvar_11 = (_WorldSpaceCameraPos - tmpvar_14.xyz);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  worldNormal_3 = tmpvar_16;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = worldTangent_2.x;
  tmpvar_21.y = worldBinormal_1.x;
  tmpvar_21.z = worldNormal_3.x;
  mediump vec3 tmpvar_22;
  tmpvar_22.x = worldTangent_2.y;
  tmpvar_22.y = worldBinormal_1.y;
  tmpvar_22.z = worldNormal_3.y;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_2.z;
  tmpvar_23.y = worldBinormal_1.z;
  tmpvar_23.z = worldNormal_3.z;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(_glesNormal);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_26 = _glesTANGENT.xyz;
  tmpvar_27 = (((tmpvar_24.yzx * tmpvar_25.zxy) - (tmpvar_24.zxy * tmpvar_25.yzx)) * _glesTANGENT.w);
  tmpvar_28 = _glesNormal;
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_26.x;
  tmpvar_29[0].y = tmpvar_27.x;
  tmpvar_29[0].z = tmpvar_28.x;
  tmpvar_29[1].x = tmpvar_26.y;
  tmpvar_29[1].y = tmpvar_27.y;
  tmpvar_29[1].z = tmpvar_28.y;
  tmpvar_29[2].x = tmpvar_26.z;
  tmpvar_29[2].y = tmpvar_27.z;
  tmpvar_29[2].z = tmpvar_28.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_29 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_30)
  .xyz)));
  tmpvar_8 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_31;
  fogTune_31 = _FogTune;
  mediump vec4 tmpvar_32;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, (sqrt(
      dot (tmpvar_34, tmpvar_34)
    ) - _FogStartDistance));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_35))
       * 
        (_FogIntensity * tmpvar_35)
      ) * fogTune_31)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_35)) * (_FogColorIntensity * tmpvar_35))
    ), 0.0, 1.0)));
    fogColor_33.xyz = tmpvar_37;
    fogColor_33.w = tmpvar_36;
    tmpvar_32 = fogColor_33;
  } else {
    mediump vec4 fogColor_38;
    highp vec3 tmpvar_39;
    tmpvar_39 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_40;
    tmpvar_40 = max (0.0, (sqrt(
      dot (tmpvar_39, tmpvar_39)
    ) - _FogStartDistance));
    highp float tmpvar_41;
    tmpvar_41 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_31)), _FogEffectLimit);
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_40) / max (0.1, ((_FogEndDistance * fogTune_31) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_38.xyz = tmpvar_42;
    fogColor_38.w = tmpvar_41;
    tmpvar_32 = fogColor_38;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_32;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
  xlv_TEXCOORD9 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec3 normals_6;
  mediump vec4 tex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_5 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD2, normals_6);
  worldNorm_3.x = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3, normals_6);
  worldNorm_3.y = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD4, normals_6);
  worldNorm_3.z = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixV[0].xyz;
  tmpvar_15[1] = unity_MatrixV[1].xyz;
  tmpvar_15[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_15 * worldNorm_3);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (worldNorm_3, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((tmpvar_16.xy * 0.5) + 0.5);
  tmpvar_17 = texture2D (_MatCap, P_18);
  mc_2 = tmpvar_17;
  mc_2.xyz = mix (vec3(1.0, 1.0, 1.0), mc_2.xyz, vec3(matcapMask_4));
  mc_2 = ((mc_2 * tex_7) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_19;
  tmpvar_19 = ((mc_2.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_1 = tmpvar_19;
  colorBlendLightMap_1 = (colorBlendLightMap_1 * _EnvColor.xyz);
  highp float tmpvar_20;
  tmpvar_20 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (normalize(xlv_TEXCOORD8), normalize(xlv_TEXCOORD9)))
  , _fresnelIndensity)));
  colorBlendLightMap_1 = (colorBlendLightMap_1 + (tmpvar_20 * _fresnelColA.xyz));
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_22;
  tmpvar_22 = mix (tmpvar_21, vec3(dot (tmpvar_21, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22;
  tmpvar_23.w = _BloomFactor;
  gl_FragData[0] = tmpvar_23;
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
}
}
}
Fallback "VertexLit"
}