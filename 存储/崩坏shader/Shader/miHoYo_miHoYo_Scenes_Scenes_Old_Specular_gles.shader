//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Specular" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
[Toggle] _UseMainTexAlphaAsMask ("Use Main Tex Alpha as Mask", Float) = 0
_ShadowTex ("LightMap (RGB)", 2D) = "white" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
_LightMapThreshold ("Light Map Threshold", Range(0, 1)) = 0.5
[Toggle] _UseMiHoYoLightDir ("Use Env Light Dir", Float) = 1
_LightDir ("Light Dir", Vector) = (0,-1,0,0)
_Shininess ("Shininess", Range(0, 100)) = 10
_SpeculaColor ("Specular Color", Color) = (1,1,1,1)
_SpecularIntensity ("Specular Intensity", Range(0, 10)) = 1
[Toggle] _UseNormalMap ("Use Normal Map", Float) = 0
_NormalMap ("Normal Map", 2D) = "green" { }
_NormalMapScaleX ("Normal Map Scale X", Range(0, 1)) = 1
_NormalMapScaleY ("Normal Map Scale Y", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 54418
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _UseNormalMap;
uniform highp vec4 _NormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesTANGENT;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_7 = tmpvar_12;
  if (bool(_UseNormalMap)) {
    mediump vec4 wTangent_13;
    mediump vec3 wNormal_14;
    highp vec3 norm_15;
    norm_15 = tmpvar_1;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((norm_15 * tmpvar_16));
    wNormal_14 = tmpvar_17;
    highp vec3 dir_18;
    dir_18 = tmpvar_2.xyz;
    highp mat3 tmpvar_19;
    tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_20;
    tmpvar_20 = normalize((tmpvar_19 * dir_18));
    wTangent_13.xyz = tmpvar_20;
    wTangent_13.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
    mediump vec3 tmpvar_21;
    tmpvar_21 = (((wNormal_14.yzx * wTangent_13.zxy) - (wNormal_14.zxy * wTangent_13.yzx)) * wTangent_13.w);
    mediump vec3 tmpvar_22;
    tmpvar_22.x = wTangent_13.x;
    tmpvar_22.y = tmpvar_21.x;
    tmpvar_22.z = wNormal_14.x;
    mediump vec3 tmpvar_23;
    tmpvar_23.x = wTangent_13.y;
    tmpvar_23.y = tmpvar_21.y;
    tmpvar_23.z = wNormal_14.y;
    mediump vec3 tmpvar_24;
    tmpvar_24.x = wTangent_13.z;
    tmpvar_24.y = tmpvar_21.z;
    tmpvar_24.z = wNormal_14.z;
    tmpvar_8 = tmpvar_22;
    tmpvar_9 = tmpvar_23;
    tmpvar_10 = tmpvar_24;
  } else {
    highp vec3 norm_25;
    norm_25 = tmpvar_1;
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_WorldToObject[0].xyz;
    tmpvar_26[1] = unity_WorldToObject[1].xyz;
    tmpvar_26[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = normalize((norm_25 * tmpvar_26));
    tmpvar_8 = tmpvar_27;
  };
  mediump vec4 tmpvar_28;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_29;
    highp vec3 tmpvar_30;
    tmpvar_30 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_31;
    tmpvar_31 = max (0.0, (sqrt(
      dot (tmpvar_30, tmpvar_30)
    ) - _FogStartDistance));
    highp float tmpvar_32;
    tmpvar_32 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_31)
      ) * (_FogIntensity * tmpvar_31))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_31)) * (_FogColorIntensity * tmpvar_31))
    ), 0.0, 1.0)));
    fogColor_29.xyz = tmpvar_33;
    fogColor_29.w = tmpvar_32;
    tmpvar_28 = fogColor_29;
  } else {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = (_FogEndDistance - _FogStartDistance);
    tmpvar_37 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_36) / max (0.1, tmpvar_38))
    , 0.0, 1.0))));
    fogColor_34.xyz = tmpvar_39;
    fogColor_34.w = tmpvar_37;
    tmpvar_28 = fogColor_34;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _UseMainTexAlphaAsMask;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LightMapThreshold;
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump float _Shininess;
uniform mediump vec3 _SpeculaColor;
uniform mediump float _SpecularIntensity;
uniform mediump float _UseNormalMap;
uniform sampler2D _NormalMap;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump float specular_1;
  mediump vec3 I_2;
  mediump vec3 normal_3;
  mediump vec3 diffColor_4;
  mediump vec4 ShadowColor_5;
  mediump vec4 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_6 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  ShadowColor_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (baseTexColor_6.xyz * _Color.xyz);
  diffColor_4 = tmpvar_10;
  diffColor_4 = ((2.0 * diffColor_4) * (ShadowColor_5.xyz * _LightMapIntensity));
  if (bool(_UseNormalMap)) {
    mediump vec3 normalFromMap_11;
    lowp vec3 tmpvar_12;
    tmpvar_12 = ((texture2D (_NormalMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
    normalFromMap_11 = tmpvar_12;
    mediump vec3 o_13;
    o_13.x = dot (xlv_TEXCOORD5, normalFromMap_11);
    o_13.y = dot (xlv_TEXCOORD6, normalFromMap_11);
    o_13.z = dot (xlv_TEXCOORD7, normalFromMap_11);
    normal_3 = o_13;
  } else {
    normal_3 = xlv_TEXCOORD5;
  };
  mediump vec3 tmpvar_14;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_14 = _miHoYo_LightDir;
  } else {
    tmpvar_14 = _LightDir;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  I_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (max (0.0, pow (
    max (dot (normal_3, normalize((
      -(tmpvar_14)
     + I_2))), 0.001)
  , _Shininess)) * _SpecularIntensity);
  specular_1 = tmpvar_16;
  if (bool(_UseMainTexAlphaAsMask)) {
    specular_1 = (tmpvar_16 * baseTexColor_6.w);
  };
  specular_1 = (specular_1 * float((
    dot (ShadowColor_5.xyz, vec3(0.22, 0.707, 0.071))
   >= _LightMapThreshold)));
  outColor_7.xyz = (diffColor_4 + (specular_1 * _SpeculaColor));
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_7;
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
}