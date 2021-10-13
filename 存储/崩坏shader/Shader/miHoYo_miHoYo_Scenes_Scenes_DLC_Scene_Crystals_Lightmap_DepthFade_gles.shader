//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/Scene_Crystals_Lightmap_DepthFade" {
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
[MHYHeaderBox(DEPTHFADE)] _DepthFadeColor ("DepthFadeColor", Color) = (0,0,0,0)
_DepthFadeDistance ("DepthFadeDistance", Range(0, 30)) = 0
_DepthFadeTexIntensity ("DepthFadeIntensity", Float) = 1
_DepthFadeTex ("DepthFadeTex", 2D) = "white" { }
_Transparent ("_Trans", Range(0, 1)) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" }
  GpuProgramID 40945
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_4.w = tmpvar_22.w;
  lowp vec4 color_23;
  color_23 = tmpvar_22;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_23.xyz);
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_24;
  tmpvar_24 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_DepthFadeTex, tmpvar_25);
  DepthFadeTex_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_27.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_27.z * 0.5) + 0.5);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_29)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_30.w = tmpvar_24;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_4.w = tmpvar_22.w;
  lowp vec4 color_23;
  color_23 = tmpvar_22;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_23.xyz);
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_24;
  tmpvar_24 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_DepthFadeTex, tmpvar_25);
  DepthFadeTex_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_27.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_27.z * 0.5) + 0.5);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_29)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_30.w = tmpvar_24;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_4.w = tmpvar_22.w;
  lowp vec4 color_23;
  color_23 = tmpvar_22;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_23.xyz);
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_24;
  tmpvar_24 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_DepthFadeTex, tmpvar_25);
  DepthFadeTex_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_27.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_27.z * 0.5) + 0.5);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_29)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_30.w = tmpvar_24;
  tmpvar_1 = tmpvar_30;
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
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_4.w = tmpvar_22.w;
  lowp vec4 color_23;
  color_23 = tmpvar_22;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_23.xyz);
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_24;
  tmpvar_24 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_DepthFadeTex, tmpvar_25);
  DepthFadeTex_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_27.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_27.z * 0.5) + 0.5);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_29)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_30.w = tmpvar_24;
  tmpvar_1 = tmpvar_30;
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
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_4.w = tmpvar_22.w;
  lowp vec4 color_23;
  color_23 = tmpvar_22;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_23.xyz);
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_24;
  tmpvar_24 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_DepthFadeTex, tmpvar_25);
  DepthFadeTex_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_27.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_27.z * 0.5) + 0.5);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_29)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_30.w = tmpvar_24;
  tmpvar_1 = tmpvar_30;
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
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_4.w = tmpvar_22.w;
  lowp vec4 color_23;
  color_23 = tmpvar_22;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_23.xyz);
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_24;
  tmpvar_24 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_DepthFadeTex, tmpvar_25);
  DepthFadeTex_3 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_27.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_27.z * 0.5) + 0.5);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_29)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_30.w = tmpvar_24;
  tmpvar_1 = tmpvar_30;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_4 = tmpvar_22;
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DepthFadeTex, tmpvar_24);
  DepthFadeTex_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_26.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_26.z * 0.5) + 0.5);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_28;
  z_28 = tmpvar_27.x;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_28)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_29.w = tmpvar_23;
  tmpvar_1 = tmpvar_29;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_4 = tmpvar_22;
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DepthFadeTex, tmpvar_24);
  DepthFadeTex_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_26.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_26.z * 0.5) + 0.5);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_28;
  z_28 = tmpvar_27.x;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_28)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_29.w = tmpvar_23;
  tmpvar_1 = tmpvar_29;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_4 = tmpvar_22;
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DepthFadeTex, tmpvar_24);
  DepthFadeTex_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_26.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_26.z * 0.5) + 0.5);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_28;
  z_28 = tmpvar_27.x;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_28)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_29.w = tmpvar_23;
  tmpvar_1 = tmpvar_29;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_4 = tmpvar_22;
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DepthFadeTex, tmpvar_24);
  DepthFadeTex_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_26.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_26.z * 0.5) + 0.5);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_28;
  z_28 = tmpvar_27.x;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_28)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_29.w = tmpvar_23;
  tmpvar_1 = tmpvar_29;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_4 = tmpvar_22;
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DepthFadeTex, tmpvar_24);
  DepthFadeTex_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_26.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_26.z * 0.5) + 0.5);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_28;
  z_28 = tmpvar_27.x;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_28)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_29.w = tmpvar_23;
  tmpvar_1 = tmpvar_29;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump float _FogTune;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xy = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = normalize((_glesNormal * tmpvar_7));
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
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
  tmpvar_3.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = o_20;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _DepthFadeColor;
uniform highp float _DepthFadeDistance;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform highp float _DepthFadeTexIntensity;
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
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 ase_screenPosNorm_2;
  mediump vec4 DepthFadeTex_3;
  mediump vec4 lmtex_4;
  mediump vec3 finalColor_5;
  mediump float Alpha_6;
  mediump vec3 I_7;
  mediump vec3 emissionMask_8;
  mediump vec3 reflection_9;
  mediump vec3 R_10;
  mediump vec4 tex_C_Color_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_11 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((xlv_TEXCOORD2.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 - (2.0 * (
    dot (xlv_TEXCOORD3, tmpvar_13)
   * xlv_TEXCOORD3)));
  R_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = textureCube (_RefractTex, R_10).xyz;
  reflection_9 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_EmissionMask, tmpvar_16).xyz;
  emissionMask_8 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  I_7 = tmpvar_18;
  mediump vec3 N_19;
  N_19 = xlv_TEXCOORD3;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (0.0, 1.0, ((_Color.w + emissionMask_8.x) * _FresnelParams.w));
  highp float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _Transparent);
  Alpha_6 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_4 = tmpvar_22;
  finalColor_5 = (((
    (((reflection_9 * _ReflectionStrength) + (tex_C_Color_11.xyz * _Color.xyz)) + ((emissionMask_8 * _Emission.xyz) * (_Emission.w * 2.0)))
   + 
    ((_FresnelParams.z + max (0.0, (
      pow (clamp ((1.0 - dot (I_7, N_19)), 0.001, 1.0), _FresnelParams.x)
     * _FresnelParams.y))) * tex_C_Color_11.xyz)
  ) * _ColorScale) * mix (vec3(1.0, 1.0, 1.0), lmtex_4.xyz, vec3(_LightMapIntensity)));
  finalColor_5 = mix (finalColor_5, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (Alpha_6, 0.0, 1.0);
  Alpha_6 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DepthFadeTex, tmpvar_24);
  DepthFadeTex_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm_2.xyw = tmpvar_26.xyw;
  ase_screenPosNorm_2.z = ((tmpvar_26.z * 0.5) + 0.5);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD4);
  highp float z_28;
  z_28 = tmpvar_27.x;
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = mix (((
    (_DepthFadeColor * _DepthFadeTexIntensity)
   * DepthFadeTex_3.x).xyz + finalColor_5), finalColor_5, vec3(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_28)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_2.z)
     + _ZBufferParams.w)))) / _DepthFadeDistance)
  ), 0.0, 1.0)));
  tmpvar_29.w = tmpvar_23;
  tmpvar_1 = tmpvar_29;
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