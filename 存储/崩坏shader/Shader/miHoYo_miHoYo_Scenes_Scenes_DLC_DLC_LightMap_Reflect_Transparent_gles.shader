//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_LightMap_Reflect_Transparent" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (1,1,0,0)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
[Toggle(LUMINANCE)] _Luminance ("Luminance", Float) = 0
_LumiFactor ("Luminance Factor", Float) = 0
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-100" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent-100" "RenderType" = "Transparent" }
  GpuProgramID 19242
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_7.w;
  lowp vec4 color_8;
  color_8 = tmpvar_7;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_8.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_10.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_11;
  tmpvar_11 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_12;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_13;
  srcColor_13 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump vec3 _LightingColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  tex_C_Color_4.xyz = (tex_C_Color_4.xyz + ((tmpvar_9.xyz * tex_C_Color_4.w) * _Reflectivity));
  highp vec3 tmpvar_10;
  tmpvar_10 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_11;
  outColor_5.w = _Color.w;
  mediump vec3 srcColor_12;
  srcColor_12 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_12, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_5.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform mediump vec4 _MainTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_11.xz - ((tmpvar_11.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = cos(_CamRotate);
  cost_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = sin(_CamRotate);
  sint_2 = tmpvar_14;
  highp mat2 tmpvar_15;
  tmpvar_15[0].x = cost_3;
  tmpvar_15[0].y = -(sint_2);
  tmpvar_15[1].x = sint_2;
  tmpvar_15[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_15 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_16;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, (sqrt(
      dot (tmpvar_18, tmpvar_18)
    ) - _FogStartDistance));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_19)
      ) * (_FogIntensity * tmpvar_19))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_19)) * (_FogColorIntensity * tmpvar_19))
    ), 0.0, 1.0)));
    fogColor_17.xyz = tmpvar_21;
    fogColor_17.w = tmpvar_20;
    tmpvar_16 = fogColor_17;
  } else {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    highp float tmpvar_26;
    tmpvar_26 = (_FogEndDistance - _FogStartDistance);
    tmpvar_25 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_24) / max (0.1, tmpvar_26))
    , 0.0, 1.0))));
    fogColor_22.xyz = tmpvar_27;
    fogColor_22.w = tmpvar_25;
    tmpvar_16 = fogColor_22;
  };
  mediump vec3 fogParam_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_31;
  tmpvar_31 = max (0.0, (sqrt(
    dot (tmpvar_30, tmpvar_30)
  ) - _UWFogDistStart));
  highp float tmpvar_32;
  tmpvar_32 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_31)
    ) * (_UWFogDensity * tmpvar_31))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_31))
   * 
    (_UWFogColorNFIntensity * tmpvar_31)
  )), 0.0, 1.0);
  fogParam_28.x = tmpvar_33;
  fogParam_28.y = tmpvar_32;
  fogParam_28.z = tmpvar_29.y;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_COLOR1 = tmpvar_16;
  xlv_TEXCOORD4 = fogParam_28;
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
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.xyz = vec3(0.0, 0.0, 0.0);
  outColor_1.w = _Color.w;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD4;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    mediump vec4 tmpvar_8;
    tmpvar_8.w = 0.0;
    tmpvar_8.xyz = outColor_1.xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_8, fogParam_3.zzzz).xyz;
    outColor_1.xyz = tmpvar_9;
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = outColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_10, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_11;
  };
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_1.w = clamp (_Color.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
Keywords { "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" "_LightMap_ON" }
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_LightMap_ON" }
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
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
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
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
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
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
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
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_LightMap_ON" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_LightMap_ON" }
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
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_LightMap_ON" }
""
}
}
}
}
Fallback "Diffuse"
}