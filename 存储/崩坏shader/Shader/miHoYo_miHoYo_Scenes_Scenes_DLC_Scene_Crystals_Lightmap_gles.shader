//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/Scene_Crystals_Lightmap" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Albedo |RGB(base color)", 2D) = "white" { }
_ReflectionStrength ("Reflection Strength", Range(0, 2)) = 1
_EnvironmentLight ("Environment Light", Range(0, 2)) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
_ColorScale ("ColorScale", Range(0, 1)) = 0.4
_RefractTex ("Refraction Texture", Cube) = "" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
[MHYHeaderBox(EMISSION)] _EmissionMask ("Emission Mask", 2D) = "black" { }
[Enum(UV1st,0,UV2nd,1)] _UseSet ("UV Set", Float) = 1
_Emission ("Emission Color", Color) = (0,0,0,0.5)
_EmissionGIIntensity ("Emission GI Intensity", Range(0, 10)) = 2
[MHYHeaderBox(CUSTOMLIGHTMAP)] [Toggle(_LightMap_ON)] _EnableLightmapOn ("Enable Lightmap On", Float) = 1
_LightMapIntensity ("Light Map Intensity", Float) = 1
_SpecialState ("Special State", Float) = 0
_Transparent ("_Trans", Range(0, 1)) = 1
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" }
  GpuProgramID 15423
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _FogTune;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_1.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_1.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = finalColor_2;
  tmpvar_21.w = Alpha_3;
  gl_FragData[0] = tmpvar_21;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _FogTune;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_1.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_1.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = finalColor_2;
  tmpvar_21.w = Alpha_3;
  gl_FragData[0] = tmpvar_21;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _FogTune;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_1.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_1.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = finalColor_2;
  tmpvar_21.w = Alpha_3;
  gl_FragData[0] = tmpvar_21;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _FogTune;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_1.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_1.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = finalColor_2;
  tmpvar_21.w = Alpha_3;
  gl_FragData[0] = tmpvar_21;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _FogTune;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_1.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_1.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = finalColor_2;
  tmpvar_21.w = Alpha_3;
  gl_FragData[0] = tmpvar_21;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
highp mat4 unity_MatrixMV;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump float _FogTune;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_1.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_1.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = finalColor_2;
  tmpvar_21.w = Alpha_3;
  gl_FragData[0] = tmpvar_21;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_1 = tmpvar_19;
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = finalColor_2;
  tmpvar_20.w = Alpha_3;
  gl_FragData[0] = tmpvar_20;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_1 = tmpvar_19;
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = finalColor_2;
  tmpvar_20.w = Alpha_3;
  gl_FragData[0] = tmpvar_20;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_1 = tmpvar_19;
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = finalColor_2;
  tmpvar_20.w = Alpha_3;
  gl_FragData[0] = tmpvar_20;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_1 = tmpvar_19;
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = finalColor_2;
  tmpvar_20.w = Alpha_3;
  gl_FragData[0] = tmpvar_20;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_1 = tmpvar_19;
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = finalColor_2;
  tmpvar_20.w = Alpha_3;
  gl_FragData[0] = tmpvar_20;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
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
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  tmpvar_4.w = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform mediump float _LightMapIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 lmtex_1;
  mediump vec3 finalColor_2;
  mediump float Alpha_3;
  mediump vec3 I_4;
  mediump vec3 emissionMask_5;
  mediump vec3 reflection_6;
  mediump vec3 R_7;
  mediump vec4 tex_C_Color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_8 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_10)
   * xlv_TEXCOORD3)));
  R_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = textureCube (_RefractTex, R_7).xyz;
  reflection_6 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMask, tmpvar_13).xyz;
  emissionMask_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_4 = tmpvar_15;
  mediump vec3 N_16;
  N_16 = xlv_TEXCOORD3;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (0.0, 1.0, ((_Color.w + emissionMask_5.x) * _FresnelParams.w));
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * _Transparent);
  Alpha_3 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_1 = tmpvar_19;
  finalColor_2 = (((
    (((reflection_6 * _ReflectionStrength) + (tex_C_Color_8.xyz * _Color.xyz)) + ((emissionMask_5 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_4, N_16)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_8.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_1.xyz, vec3(_LightMapIntensity)));
  finalColor_2 = mix (finalColor_2, xlv_COLOR1.xyz, xlv_COLOR1.www);
  Alpha_3 = (clamp (Alpha_3, 0.0, 1.0) * xlv_TEXCOORD2.w);
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = finalColor_2;
  tmpvar_20.w = Alpha_3;
  gl_FragData[0] = tmpvar_20;
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
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Meta/META_ADD"
}
CustomEditor "MoleMoleEditor.CharacterAvatarShaderGUI"
}