//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Scene_Air_LightMap_Crystals" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Albedo |RGB(base color)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
_ReflectionStrength ("Reflection Strength", Range(0, 2)) = 1
_EnvironmentLight ("Environment Light", Range(0, 2)) = 1
_EmissionTex ("EmissionMask", 2D) = "white" { }
_EmissionColor ("EmissionColor", Color) = (1,1,1,1)
_Emission ("Emission", Range(0, 2)) = 0
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
_ColorScale ("ColorScale", Range(0, 1)) = 0.4
_RefractTex ("Refraction Texture", Cube) = "" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" }
  GpuProgramID 36279
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 I_2;
  mediump vec4 Emission_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_S_Color_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_6 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_10)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_4 * _ReflectionStrength) + (tex_C_Color_7.xyz * _Color.xyz)) + ((Emission_3.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_2, N_15)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_7.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_16.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_3.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_16;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 I_2;
  mediump vec4 Emission_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_S_Color_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_6 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_10)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_4 * _ReflectionStrength) + (tex_C_Color_7.xyz * _Color.xyz)) + ((Emission_3.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_2, N_15)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_7.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_16.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_3.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_16;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 I_2;
  mediump vec4 Emission_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_S_Color_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_6 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_10)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_4 * _ReflectionStrength) + (tex_C_Color_7.xyz * _Color.xyz)) + ((Emission_3.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_2, N_15)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_7.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_16.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_3.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_16;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 I_2;
  mediump vec4 Emission_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_S_Color_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_6 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_10)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_4 * _ReflectionStrength) + (tex_C_Color_7.xyz * _Color.xyz)) + ((Emission_3.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_2, N_15)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_7.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_16.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_3.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_16;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 I_2;
  mediump vec4 Emission_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_S_Color_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_6 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_10)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_4 * _ReflectionStrength) + (tex_C_Color_7.xyz * _Color.xyz)) + ((Emission_3.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_2, N_15)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_7.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_16.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_3.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_16;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 I_2;
  mediump vec4 Emission_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_S_Color_6;
  mediump vec4 tex_C_Color_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_6 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_10)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_14;
  mediump vec3 N_15;
  N_15 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_4 * _ReflectionStrength) + (tex_C_Color_7.xyz * _Color.xyz)) + ((Emission_3.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_2, N_15)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_7.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_16.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_3.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_16;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 finalColor_2;
  mediump vec3 I_3;
  mediump vec4 Emission_4;
  mediump vec3 reflection_5;
  mediump vec3 R_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_11)
   * xlv_TEXCOORD2)));
  R_6 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_6).xyz;
  reflection_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_4 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_3 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_5 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((Emission_4.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_3, N_16)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_8.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  finalColor_2 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = mix (finalColor_2, vec3(dot (finalColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = finalColor_2;
  tmpvar_17.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_4.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_17;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 finalColor_2;
  mediump vec3 I_3;
  mediump vec4 Emission_4;
  mediump vec3 reflection_5;
  mediump vec3 R_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_11)
   * xlv_TEXCOORD2)));
  R_6 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_6).xyz;
  reflection_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_4 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_3 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_5 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((Emission_4.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_3, N_16)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_8.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  finalColor_2 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = mix (finalColor_2, vec3(dot (finalColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = finalColor_2;
  tmpvar_17.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_4.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_17;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 finalColor_2;
  mediump vec3 I_3;
  mediump vec4 Emission_4;
  mediump vec3 reflection_5;
  mediump vec3 R_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_11)
   * xlv_TEXCOORD2)));
  R_6 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_6).xyz;
  reflection_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_4 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_3 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_5 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((Emission_4.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_3, N_16)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_8.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  finalColor_2 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = mix (finalColor_2, vec3(dot (finalColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = finalColor_2;
  tmpvar_17.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_4.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_17;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 finalColor_2;
  mediump vec3 I_3;
  mediump vec4 Emission_4;
  mediump vec3 reflection_5;
  mediump vec3 R_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_11)
   * xlv_TEXCOORD2)));
  R_6 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_6).xyz;
  reflection_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_4 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_3 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_5 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((Emission_4.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_3, N_16)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_8.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  finalColor_2 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = mix (finalColor_2, vec3(dot (finalColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = finalColor_2;
  tmpvar_17.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_4.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_17;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 finalColor_2;
  mediump vec3 I_3;
  mediump vec4 Emission_4;
  mediump vec3 reflection_5;
  mediump vec3 R_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_11)
   * xlv_TEXCOORD2)));
  R_6 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_6).xyz;
  reflection_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_4 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_3 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_5 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((Emission_4.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_3, N_16)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_8.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  finalColor_2 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = mix (finalColor_2, vec3(dot (finalColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = finalColor_2;
  tmpvar_17.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_4.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_17;
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
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_7;
  fogTune_7 = _FogTune;
  mediump vec4 tmpvar_8;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_9;
    highp vec3 tmpvar_10;
    tmpvar_10 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, (sqrt(
      dot (tmpvar_10, tmpvar_10)
    ) - _FogStartDistance));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_11))
       * 
        (_FogIntensity * tmpvar_11)
      ) * fogTune_7)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_11)) * (_FogColorIntensity * tmpvar_11))
    ), 0.0, 1.0)));
    fogColor_9.xyz = tmpvar_13;
    fogColor_9.w = tmpvar_12;
    tmpvar_8 = fogColor_9;
  } else {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_7)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, ((_FogEndDistance * fogTune_7) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex;
uniform sampler2D _EmissionTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EmissionColor;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _Emission;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec3 finalColor_2;
  mediump vec3 I_3;
  mediump vec4 Emission_4;
  mediump vec3 reflection_5;
  mediump vec3 R_6;
  mediump vec4 tex_S_Color_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD3);
  tex_S_Color_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_11)
   * xlv_TEXCOORD2)));
  R_6 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_6).xyz;
  reflection_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionTex, xlv_TEXCOORD0);
  Emission_4 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_3 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD2;
  colorBlendLightMap_1 = (((
    ((((reflection_5 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((Emission_4.xyz * _EmissionColor.xyz) * _Emission)) + ((_FresnelParams.z + max (0.0, 
      (pow (clamp ((1.0 - 
        dot (I_3, N_16)
      ), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
    )) * tex_C_Color_8.xyz))
   * _ColorScale) * (
    (((2.0 * tex_S_Color_7.xyz) * tex_S_Color_7.w) + 1.0)
   - tex_S_Color_7.w)) * _LightMapIntensity);
  finalColor_2 = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = mix (finalColor_2, vec3(dot (finalColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = finalColor_2;
  tmpvar_17.w = clamp (clamp (0.0, 1.0, (
    (_Color.w + Emission_4.x)
   * _FresnelParams.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_17;
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