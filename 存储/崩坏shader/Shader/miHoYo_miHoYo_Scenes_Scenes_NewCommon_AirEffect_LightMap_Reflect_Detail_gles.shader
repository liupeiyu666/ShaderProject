//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/AirEffect_LightMap_Reflect_Detail" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_MainColor ("Main Color", Color) = (1,1,1,1)
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
[MHYSingleLineTextureNoScaleOffset] _ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
[MHYHeaderBox(SeprateAlpha)] [Toggle(_Enable_Seprate_Alpha)] _EnableSperateAlpha ("Enable Seprate Alpha", Float) = 1
_MainTex_Alpha ("R(Alpha)", 2D) = "white" { }
[MHYHeaderBox(Reflect)] _EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
[MHYHeaderBox(Fresnel)] [Toggle(_Enable_Fresnel)] _EnableFresnel ("Enable Fresnel", Float) = 1
_fresnelCol ("FresnelCol", Color) = (1,1,1,1)
_fresnelBase ("FresnelBase", Range(0, 4)) = 1
_fresnelScale ("FresnelScale", Range(0, 4)) = 1
_fresnelIndensity ("FresnelIndensity", Range(0, 5)) = 5
[MHYHeaderBox(Detail)] _DetailTex ("Second Texture", 2D) = "black" { }
_DetailIntensity ("Detail Intensity", Float) = 1
_DetailSpeed ("Detail Speed", Float) = 0
_FogTune ("Fog Tune", Range(0, 1)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_Transparent ("_Trans", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 36055
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform mediump float _LumiFactor;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform mediump float _LumiFactor;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
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
uniform highp vec4 _Time;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform mediump float _LumiFactor;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  mediump vec3 fogParam_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_24.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_26;
  tmpvar_26 = max (0.0, (sqrt(
    dot (tmpvar_25, tmpvar_25)
  ) - _UWFogDistStart));
  highp float tmpvar_27;
  tmpvar_27 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_26)
    ) * (_UWFogDensity * tmpvar_26))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_26))
   * 
    (_UWFogColorNFIntensity * tmpvar_26)
  )), 0.0, 1.0);
  fogParam_23.x = tmpvar_28;
  fogParam_23.y = tmpvar_27;
  fogParam_23.z = tmpvar_24.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD5 = fogParam_23;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  if ((xlv_TEXCOORD5.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_18;
    xlat_varinput_18 = xlv_TEXCOORD5;
    mediump vec3 fogParam_19;
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD5.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_20))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_22;
    tmpvar_22 = clamp ((_UWFogColorHLIntensity * tmpvar_20), 0.0, 1.0);
    fogParam_19.z = 0.0;
    fogParam_19.y = tmpvar_21;
    fogParam_19.x = tmpvar_22;
    if ((xlv_TEXCOORD5.y > 0.99)) {
      xlat_varinput_18.y = (xlv_TEXCOORD5.y * (1.0 - (tmpvar_20 * _UWHeightRatio)));
      highp float tmpvar_23;
      tmpvar_23 = clamp (xlat_varinput_18.y, _UWCriticalRange, 1.0);
      xlat_varinput_18.y = tmpvar_23;
    };
    fogParam_19.z = (1.0 - xlat_varinput_18.y);
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD5.xxxx), tmpvar_24, fogParam_19.zzzz).xyz;
    outColor_7.xyz = tmpvar_25;
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_7.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_19.xxxx), tmpvar_26, fogParam_19.yyyy).xyz;
    outColor_7.xyz = tmpvar_27;
  };
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  mediump vec3 fogParam_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_24.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_26;
  tmpvar_26 = max (0.0, (sqrt(
    dot (tmpvar_25, tmpvar_25)
  ) - _UWFogDistStart));
  highp float tmpvar_27;
  tmpvar_27 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_26)
    ) * (_UWFogDensity * tmpvar_26))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_26))
   * 
    (_UWFogColorNFIntensity * tmpvar_26)
  )), 0.0, 1.0);
  fogParam_23.x = tmpvar_28;
  fogParam_23.y = tmpvar_27;
  fogParam_23.z = tmpvar_24.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD5 = fogParam_23;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  if ((xlv_TEXCOORD5.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_18;
    xlat_varinput_18 = xlv_TEXCOORD5;
    mediump vec3 fogParam_19;
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD5.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_20))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_22;
    tmpvar_22 = clamp ((_UWFogColorHLIntensity * tmpvar_20), 0.0, 1.0);
    fogParam_19.z = 0.0;
    fogParam_19.y = tmpvar_21;
    fogParam_19.x = tmpvar_22;
    if ((xlv_TEXCOORD5.y > 0.99)) {
      xlat_varinput_18.y = (xlv_TEXCOORD5.y * (1.0 - (tmpvar_20 * _UWHeightRatio)));
      highp float tmpvar_23;
      tmpvar_23 = clamp (xlat_varinput_18.y, _UWCriticalRange, 1.0);
      xlat_varinput_18.y = tmpvar_23;
    };
    fogParam_19.z = (1.0 - xlat_varinput_18.y);
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD5.xxxx), tmpvar_24, fogParam_19.zzzz).xyz;
    outColor_7.xyz = tmpvar_25;
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_7.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_19.xxxx), tmpvar_26, fogParam_19.yyyy).xyz;
    outColor_7.xyz = tmpvar_27;
  };
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  mediump vec3 fogParam_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_24.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_26;
  tmpvar_26 = max (0.0, (sqrt(
    dot (tmpvar_25, tmpvar_25)
  ) - _UWFogDistStart));
  highp float tmpvar_27;
  tmpvar_27 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_26)
    ) * (_UWFogDensity * tmpvar_26))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_26))
   * 
    (_UWFogColorNFIntensity * tmpvar_26)
  )), 0.0, 1.0);
  fogParam_23.x = tmpvar_28;
  fogParam_23.y = tmpvar_27;
  fogParam_23.z = tmpvar_24.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD5 = fogParam_23;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  if ((xlv_TEXCOORD5.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_18;
    xlat_varinput_18 = xlv_TEXCOORD5;
    mediump vec3 fogParam_19;
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD5.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_20))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_22;
    tmpvar_22 = clamp ((_UWFogColorHLIntensity * tmpvar_20), 0.0, 1.0);
    fogParam_19.z = 0.0;
    fogParam_19.y = tmpvar_21;
    fogParam_19.x = tmpvar_22;
    if ((xlv_TEXCOORD5.y > 0.99)) {
      xlat_varinput_18.y = (xlv_TEXCOORD5.y * (1.0 - (tmpvar_20 * _UWHeightRatio)));
      highp float tmpvar_23;
      tmpvar_23 = clamp (xlat_varinput_18.y, _UWCriticalRange, 1.0);
      xlat_varinput_18.y = tmpvar_23;
    };
    fogParam_19.z = (1.0 - xlat_varinput_18.y);
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD5.xxxx), tmpvar_24, fogParam_19.zzzz).xyz;
    outColor_7.xyz = tmpvar_25;
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_7.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_19.xxxx), tmpvar_26, fogParam_19.yyyy).xyz;
    outColor_7.xyz = tmpvar_27;
  };
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  mediump vec3 fogParam_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_24.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_26;
  tmpvar_26 = max (0.0, (sqrt(
    dot (tmpvar_25, tmpvar_25)
  ) - _UWFogDistStart));
  highp float tmpvar_27;
  tmpvar_27 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_26)
    ) * (_UWFogDensity * tmpvar_26))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_26))
   * 
    (_UWFogColorNFIntensity * tmpvar_26)
  )), 0.0, 1.0);
  fogParam_23.x = tmpvar_28;
  fogParam_23.y = tmpvar_27;
  fogParam_23.z = tmpvar_24.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD5 = fogParam_23;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform mediump float _LumiFactor;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  if ((xlv_TEXCOORD5.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_18;
    xlat_varinput_18 = xlv_TEXCOORD5;
    mediump vec3 fogParam_19;
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD5.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_20))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_22;
    tmpvar_22 = clamp ((_UWFogColorHLIntensity * tmpvar_20), 0.0, 1.0);
    fogParam_19.z = 0.0;
    fogParam_19.y = tmpvar_21;
    fogParam_19.x = tmpvar_22;
    if ((xlv_TEXCOORD5.y > 0.99)) {
      xlat_varinput_18.y = (xlv_TEXCOORD5.y * (1.0 - (tmpvar_20 * _UWHeightRatio)));
      highp float tmpvar_23;
      tmpvar_23 = clamp (xlat_varinput_18.y, _UWCriticalRange, 1.0);
      xlat_varinput_18.y = tmpvar_23;
    };
    fogParam_19.z = (1.0 - xlat_varinput_18.y);
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD5.xxxx), tmpvar_24, fogParam_19.zzzz).xyz;
    outColor_7.xyz = tmpvar_25;
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_7.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_19.xxxx), tmpvar_26, fogParam_19.yyyy).xyz;
    outColor_7.xyz = tmpvar_27;
  };
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  mediump vec3 fogParam_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_24.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_26;
  tmpvar_26 = max (0.0, (sqrt(
    dot (tmpvar_25, tmpvar_25)
  ) - _UWFogDistStart));
  highp float tmpvar_27;
  tmpvar_27 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_26)
    ) * (_UWFogDensity * tmpvar_26))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_26))
   * 
    (_UWFogColorNFIntensity * tmpvar_26)
  )), 0.0, 1.0);
  fogParam_23.x = tmpvar_28;
  fogParam_23.y = tmpvar_27;
  fogParam_23.z = tmpvar_24.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD5 = fogParam_23;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform mediump float _LumiFactor;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  if ((xlv_TEXCOORD5.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_18;
    xlat_varinput_18 = xlv_TEXCOORD5;
    mediump vec3 fogParam_19;
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD5.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_20))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_22;
    tmpvar_22 = clamp ((_UWFogColorHLIntensity * tmpvar_20), 0.0, 1.0);
    fogParam_19.z = 0.0;
    fogParam_19.y = tmpvar_21;
    fogParam_19.x = tmpvar_22;
    if ((xlv_TEXCOORD5.y > 0.99)) {
      xlat_varinput_18.y = (xlv_TEXCOORD5.y * (1.0 - (tmpvar_20 * _UWHeightRatio)));
      highp float tmpvar_23;
      tmpvar_23 = clamp (xlat_varinput_18.y, _UWCriticalRange, 1.0);
      xlat_varinput_18.y = tmpvar_23;
    };
    fogParam_19.z = (1.0 - xlat_varinput_18.y);
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD5.xxxx), tmpvar_24, fogParam_19.zzzz).xyz;
    outColor_7.xyz = tmpvar_25;
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_7.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_19.xxxx), tmpvar_26, fogParam_19.yyyy).xyz;
    outColor_7.xyz = tmpvar_27;
  };
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform mediump float _FogTune;
uniform highp float _DetailSpeed;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = (_glesNormal * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  tmpvar_6 = (_WorldSpaceCameraPos - tmpvar_9.xyz);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw);
  highp float tmpvar_10;
  tmpvar_10 = fract((_Time.x * _DetailSpeed));
  tmpvar_3.y = (tmpvar_3.y + tmpvar_10);
  highp float fogTune_11;
  fogTune_11 = _FogTune;
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_15))
       * 
        (_FogIntensity * tmpvar_15)
      ) * fogTune_11)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_11)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, ((_FogEndDistance * fogTune_11) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  mediump vec3 fogParam_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_24.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_26;
  tmpvar_26 = max (0.0, (sqrt(
    dot (tmpvar_25, tmpvar_25)
  ) - _UWFogDistStart));
  highp float tmpvar_27;
  tmpvar_27 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_26)
    ) * (_UWFogDensity * tmpvar_26))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_26))
   * 
    (_UWFogColorNFIntensity * tmpvar_26)
  )), 0.0, 1.0);
  fogParam_23.x = tmpvar_28;
  fogParam_23.y = tmpvar_27;
  fogParam_23.z = tmpvar_24.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD5 = fogParam_23;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp int _EnableSperateAlpha;
uniform highp int _EnableFresnel;
uniform highp float _LightMapIntensity;
uniform highp vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
uniform sampler2D _DetailTex;
uniform mediump float _Reflectivity;
uniform highp float _fresnelBase;
uniform highp float _fresnelScale;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelCol;
uniform mediump float _DetailIntensity;
uniform mediump float _LumiFactor;
uniform highp float _Transparent;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 R_1;
  mediump vec3 colorBlendLightMap_2;
  mediump float alpha_3;
  mediump vec4 tex_D_Color_4;
  mediump vec4 tex_S_Color_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DetailTex, xlv_TEXCOORD1);
  tex_D_Color_4 = tmpvar_12;
  alpha_3 = 1.0;
  if ((_EnableSperateAlpha > 0)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_MainTex_Alpha, xlv_TEXCOORD0.xy);
    alpha_3 = tmpvar_13.x;
  } else {
    alpha_3 = tex_C_Color_6.w;
  };
  colorBlendLightMap_2 = ((tex_C_Color_6.xyz * (
    (((2.0 * tex_S_Color_5.xyz) * tex_S_Color_5.w) + 1.0)
   - tex_S_Color_5.w)) * _LightMapIntensity);
  outColor_7.xyz = colorBlendLightMap_2;
  outColor_7.w = alpha_3;
  outColor_7 = (outColor_7 * _MainColor);
  highp vec3 tmpvar_14;
  highp vec3 I_15;
  I_15 = -(tmpvar_9);
  tmpvar_14 = (I_15 - (2.0 * (
    dot (tmpvar_8, I_15)
   * tmpvar_8)));
  R_1 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_EnvTex, R_1);
  outColor_7.xyz = (outColor_7.xyz + ((tmpvar_16.xyz * alpha_3) * _Reflectivity));
  if ((_EnableFresnel > 0)) {
    highp float tmpvar_17;
    tmpvar_17 = (_fresnelBase + (_fresnelScale * pow (
      (1.001 - dot (tmpvar_8, tmpvar_9))
    , _fresnelIndensity)));
    outColor_7.xyz = (outColor_7.xyz + (tmpvar_17 * _fresnelCol.xyz));
  };
  outColor_7.xyz = (outColor_7.xyz + (tex_D_Color_4 * _DetailIntensity).xyz);
  if ((xlv_TEXCOORD5.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_18;
    xlat_varinput_18 = xlv_TEXCOORD5;
    mediump vec3 fogParam_19;
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD5.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_20))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_22;
    tmpvar_22 = clamp ((_UWFogColorHLIntensity * tmpvar_20), 0.0, 1.0);
    fogParam_19.z = 0.0;
    fogParam_19.y = tmpvar_21;
    fogParam_19.x = tmpvar_22;
    if ((xlv_TEXCOORD5.y > 0.99)) {
      xlat_varinput_18.y = (xlv_TEXCOORD5.y * (1.0 - (tmpvar_20 * _UWHeightRatio)));
      highp float tmpvar_23;
      tmpvar_23 = clamp (xlat_varinput_18.y, _UWCriticalRange, 1.0);
      xlat_varinput_18.y = tmpvar_23;
    };
    fogParam_19.z = (1.0 - xlat_varinput_18.y);
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD5.xxxx), tmpvar_24, fogParam_19.zzzz).xyz;
    outColor_7.xyz = tmpvar_25;
    mediump vec4 tmpvar_26;
    tmpvar_26.w = 0.0;
    tmpvar_26.xyz = outColor_7.xyz;
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_19.xxxx), tmpvar_26, fogParam_19.yyyy).xyz;
    outColor_7.xyz = tmpvar_27;
  };
  outColor_7.w = (alpha_3 * _Transparent);
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
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
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
}
}
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 66802
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
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
}
}
}
}