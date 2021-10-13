//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Scene_Air_LightMap_Matcap_AddLight" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
[MHYHeaderBox(MATCAP)] _MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
[MHYHeaderBox(Fresnel)] _FresnelColor ("Fresnel Color", Color) = (1,1,1,1)
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
_ColorScale ("ColorScale", Range(0, 1)) = 0.4
[MHYHeaderBox(FOG)] _FogTune ("Fog Tune", Range(0, 1)) = 1
[MHYHeaderBox(ADDLIGHT)] _AdditiveLightPower ("Additive Light Power", Range(0.1, 5)) = 1
_AdditiveLightIntensity ("Additive Light Intensity", Range(0, 1)) = 1
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 28822
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = tmpvar_16;
  tmpvar_17.w = _BloomFactor;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = tmpvar_16;
  tmpvar_17.w = _BloomFactor;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = tmpvar_16;
  tmpvar_17.w = _BloomFactor;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = tmpvar_16;
  tmpvar_17.w = _BloomFactor;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = tmpvar_16;
  tmpvar_17.w = _BloomFactor;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = tmpvar_16;
  tmpvar_17.w = _BloomFactor;
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (tmpvar_16, vec3(dot (tmpvar_16, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (tmpvar_16, vec3(dot (tmpvar_16, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (tmpvar_16, vec3(dot (tmpvar_16, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (tmpvar_16, vec3(dot (tmpvar_16, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (tmpvar_16, vec3(dot (tmpvar_16, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform mediump vec4 _FresnelColor;
uniform mediump vec4 _FresnelParams;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 I_1;
  mediump vec3 colorBlendLightMap_2;
  highp vec4 mc_3;
  mediump float matcapMask_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_4 = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_MatrixV[0].xyz;
  tmpvar_10[1] = unity_MatrixV[1].xyz;
  tmpvar_10[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((tmpvar_10 * xlv_TEXCOORD3).xy * 0.5) + 0.5);
  tmpvar_11 = texture2D (_MatCap, P_12);
  mc_3 = tmpvar_11;
  mc_3.xyz = mix (vec3(1.0, 1.0, 1.0), mc_3.xyz, vec3(matcapMask_4));
  mc_3 = ((mc_3 * tex_6) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_13;
  tmpvar_13 = ((mc_3.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  colorBlendLightMap_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_1 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD3;
  colorBlendLightMap_2 = (colorBlendLightMap_2 + ((_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_1, N_15))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ) * _FresnelColor).xyz);
  mediump vec3 tmpvar_16;
  tmpvar_16 = mix (colorBlendLightMap_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (tmpvar_16, vec3(dot (tmpvar_16, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
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
 UsePass "Hidden/miHoYo/DLC/Common/AddLight/ADDLIGHT"
}
Fallback "VertexLit"
}