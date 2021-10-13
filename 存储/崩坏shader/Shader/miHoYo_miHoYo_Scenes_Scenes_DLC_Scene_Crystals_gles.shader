//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/Scene_Crystals" {
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
_SpecialState ("Special State", Float) = 0
_Transparent ("_Trans", Range(0, 1)) = 1
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" }
  GpuProgramID 41221
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.zw = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_3.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float Alpha_1;
  mediump vec3 I_2;
  mediump vec3 emissionMask_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_C_Color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_8)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.zw, vec2(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11).xyz;
  emissionMask_3 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_13;
  mediump vec3 N_14;
  N_14 = xlv_TEXCOORD2;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (0.0, 1.0, ((_Color.w + emissionMask_3.x) * _FresnelParams.w));
  highp float tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _Transparent);
  Alpha_1 = tmpvar_16;
  mediump float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((Alpha_1 * xlv_TEXCOORD1.w), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  Alpha_1 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = mix (((
    (((reflection_4 * _ReflectionStrength) + (tex_C_Color_6.xyz * _Color.xyz)) + ((emissionMask_3 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_2, N_14)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_6.xyz)
  ) * _ColorScale), xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_19.w = tmpvar_17;
  gl_FragData[0] = tmpvar_19;
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.zw = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_3.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float Alpha_1;
  mediump vec3 I_2;
  mediump vec3 emissionMask_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_C_Color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_8)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.zw, vec2(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11).xyz;
  emissionMask_3 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_13;
  mediump vec3 N_14;
  N_14 = xlv_TEXCOORD2;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (0.0, 1.0, ((_Color.w + emissionMask_3.x) * _FresnelParams.w));
  highp float tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _Transparent);
  Alpha_1 = tmpvar_16;
  mediump float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((Alpha_1 * xlv_TEXCOORD1.w), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  Alpha_1 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = mix (((
    (((reflection_4 * _ReflectionStrength) + (tex_C_Color_6.xyz * _Color.xyz)) + ((emissionMask_3 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_2, N_14)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_6.xyz)
  ) * _ColorScale), xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_19.w = tmpvar_17;
  gl_FragData[0] = tmpvar_19;
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.zw = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_3.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float Alpha_1;
  mediump vec3 I_2;
  mediump vec3 emissionMask_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_C_Color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_8)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.zw, vec2(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11).xyz;
  emissionMask_3 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_13;
  mediump vec3 N_14;
  N_14 = xlv_TEXCOORD2;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (0.0, 1.0, ((_Color.w + emissionMask_3.x) * _FresnelParams.w));
  highp float tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _Transparent);
  Alpha_1 = tmpvar_16;
  mediump float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((Alpha_1 * xlv_TEXCOORD1.w), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  Alpha_1 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = mix (((
    (((reflection_4 * _ReflectionStrength) + (tex_C_Color_6.xyz * _Color.xyz)) + ((emissionMask_3 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_2, N_14)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_6.xyz)
  ) * _ColorScale), xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_19.w = tmpvar_17;
  gl_FragData[0] = tmpvar_19;
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.zw = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_3.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float Alpha_1;
  mediump vec3 I_2;
  mediump vec3 emissionMask_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_C_Color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_8)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.zw, vec2(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11).xyz;
  emissionMask_3 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_13;
  mediump vec3 N_14;
  N_14 = xlv_TEXCOORD2;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (0.0, 1.0, ((_Color.w + emissionMask_3.x) * _FresnelParams.w));
  highp float tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _Transparent);
  Alpha_1 = tmpvar_16;
  mediump float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((Alpha_1 * xlv_TEXCOORD1.w), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  Alpha_1 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = mix (((
    (((reflection_4 * _ReflectionStrength) + (tex_C_Color_6.xyz * _Color.xyz)) + ((emissionMask_3 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_2, N_14)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_6.xyz)
  ) * _ColorScale), xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_19.w = tmpvar_17;
  gl_FragData[0] = tmpvar_19;
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.zw = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_3.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float Alpha_1;
  mediump vec3 I_2;
  mediump vec3 emissionMask_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_C_Color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_8)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.zw, vec2(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11).xyz;
  emissionMask_3 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_13;
  mediump vec3 N_14;
  N_14 = xlv_TEXCOORD2;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (0.0, 1.0, ((_Color.w + emissionMask_3.x) * _FresnelParams.w));
  highp float tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _Transparent);
  Alpha_1 = tmpvar_16;
  mediump float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((Alpha_1 * xlv_TEXCOORD1.w), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  Alpha_1 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = mix (((
    (((reflection_4 * _ReflectionStrength) + (tex_C_Color_6.xyz * _Color.xyz)) + ((emissionMask_3 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_2, N_14)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_6.xyz)
  ) * _ColorScale), xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_19.w = tmpvar_17;
  gl_FragData[0] = tmpvar_19;
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.zw = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  tmpvar_4 = normalize((_glesNormal * tmpvar_6));
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_3.w = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
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
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump vec4 _FresnelParams;
uniform mediump float _ColorScale;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float Alpha_1;
  mediump vec3 I_2;
  mediump vec3 emissionMask_3;
  mediump vec3 reflection_4;
  mediump vec3 R_5;
  mediump vec4 tex_C_Color_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 - (2.0 * (
    dot (xlv_TEXCOORD2, tmpvar_8)
   * xlv_TEXCOORD2)));
  R_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = textureCube (_RefractTex, R_5).xyz;
  reflection_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.zw, vec2(float(_UseSet)));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMask, tmpvar_11).xyz;
  emissionMask_3 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  I_2 = tmpvar_13;
  mediump vec3 N_14;
  N_14 = xlv_TEXCOORD2;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (0.0, 1.0, ((_Color.w + emissionMask_3.x) * _FresnelParams.w));
  highp float tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _Transparent);
  Alpha_1 = tmpvar_16;
  mediump float tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp ((Alpha_1 * xlv_TEXCOORD1.w), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  Alpha_1 = tmpvar_17;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = mix (((
    (((reflection_4 * _ReflectionStrength) + (tex_C_Color_6.xyz * _Color.xyz)) + ((emissionMask_3 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_2, N_14)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_6.xyz)
  ) * _ColorScale), xlv_COLOR1.xyz, xlv_COLOR1.www);
  tmpvar_19.w = tmpvar_17;
  gl_FragData[0] = tmpvar_19;
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
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Meta/META"
}
}